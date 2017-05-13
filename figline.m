function [ ] = figline( LineWidth, MarkerSize, Style)
%FIGLINE 调整当前绘图中所有曲线线条颜色，粗细及数据点类型和大小。
%        Adjust the Color, LineWidth, LineStyle, MarkerSize and Marker of all the 
%        lines in one step. 
%
%   FIGLINE(LineWidth, MarkerSize, Style) 一次设置绘图中全部曲线，
%   保持不变则使用 [] 缺省。
%   FIGLINE(LineWidth, MarkerSize, Style) Adjust the styles of all the 
%   lines in one step, and jump the parameter constant with '[]'.
%
%   例如，FIGLINE(2) 将线宽设置为 2
%   FIGLINE(2, [], '-') 将线宽设置为 2，线形为直线。
%   FIGLINE(2, 0) 将线宽设置为 2，隐藏数据点。
%   FIGLINE(0, 6, '.') 隐藏图中曲线，绘制成散点图，散点大小为 6。
%   FIGLINE('--bros') 线宽和数据点大小保持不变，线形设置为虚线，颜色为蓝和红，
%   数据点形状分别设置为圆和方块，等效于 FIGLINE([], [], '--os')。
%
%   For example, FIGLINE(2) set the LineWidth of all the lines as 2.
%   FIGLINE(2, [], '-') Set the LineWidth as 2 and LineStyle as solid line.
%   FIGLINE(2, 0) Set the LineWidth as 2 and hide markers.
%   FIGLINE(0, 6, '.') Hide the line and set MarkerSize as 6.
%   FIGLINE('--bros') Keep the LineWidth and MarkerSize, and set the two (or
%   more) lines' color as blue and red, marker as circle and square 
%   separately. You can also use FIGLINE([], [], '--bros').
%
%   颜色 (Color): 'y' | 'm' | 'c' | 'r' | 'g' | 'b' | 'w' | 'k'
%   线形 (LineStyle): '-' | '--' | ':' 
%   数据点形状 (Marker): '+' | 'o' | '*' | '.' | 'x' | 's' | 'd' | '^' | 'v' |'<' | '>' | 'p' | 'h'
%
%   例：
%         x = -pi:pi/20:pi;
%         y = tan(sin(x)) - sin(tan(x));
%         plot(x,-y); hold on; plot(x,y+1);
%         FIGLINE(2, 24, '--.');
%

if nargin == 0
    return;
elseif nargin == 1
    if isa(LineWidth,'double')
        MarkerSize = [];
        Style = [];
    elseif isa(LineWidth,'char')
        Style = LineWidth;
        LineWidth = [];
        MarkerSize = [];
    end
elseif nargin == 2
    Style = [];
end

if ~isempty(Style) && ~isa(Style,'char')
    error('The Style is invalid');
end
if ~prod(ismember(Style,'ymcrgbwk-:+o*.xsd^v<>ph'))
    error('The Style should be y m c r g b w k - -- : + o * . x s d ^ v < > p h');
end

Color = Style(ismember(Style,'ymcrgbwk'));
LineStyle = Style(ismember(Style,'-:'));
Marker = Style(ismember(Style,'+o*.xsd^v<>ph'));

g = get(gca,'children');
h = [];
for temp = g
    if isa(temp,'matlab.graphics.chart.primitive.Line')
        h = [h temp];
    end
end

if strcmp(LineStyle,'-') || strcmp(LineStyle,'--') || strcmp(LineStyle,':')
    for ii = 1:length(h)
        set(h(ii),'LineStyle',LineStyle);
    end 
end

if ~isempty(LineWidth)
    if ~isscalar(LineWidth) || ~isa(LineWidth,'double') || LineWidth < 0
        error('The LineWidth is invalid');
    end
    if LineWidth == 0
        for temp = h
            set(temp,'LineStyle','none');
        end
    else
        for temp = h
            set(temp,'LineWidth',LineWidth);
        end
    end    
end

if ~isempty(Marker)
    % you can predefine a markertable here
    % MarkerTable = repmat(['o' 's' '^' 'v'],1,ceil(length(h)/length(Marker)));
    MarkerTable = repmat(Marker,1,ceil(length(h)/length(Marker)));
    for ii = 1:length(h)
        set(h(ii),'Marker',MarkerTable(ii));
    end 
end

if ~isempty(Color)
    % you can predefine a colortable here
    % ColorTabel = repmat(['b' 'r' 'm' 'c'],1,ceil(length(h)/length(Color)));
    ColorTable = repmat(Color,1,ceil(length(h)/length(Color)));
    for ii = 1:length(h)
        set(h(ii),'Color',ColorTable(ii));
    end 
end

if ~isempty(MarkerSize)
    if ~isscalar(MarkerSize) || ~isa(MarkerSize,'double') || MarkerSize < 0
        error('The MarkerSize is invalid');
    end
    if MarkerSize == 0
        for temp = h
            set(temp,'Marker','none');
        end
    else
        for ii = 1:length(h)
            set(h(ii),'MarkerSize',MarkerSize);
        end
    end 
end

end

