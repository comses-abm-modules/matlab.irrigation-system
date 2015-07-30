function plotCircle(x,y,r,c)

%pretty straightforward.  plot a circle at (x,y) of radius r, in color c

numPoints = 20;
angleList = 0:2*pi/numPoints:2*pi;

xVec = x + r*cos(angleList);
yVec = y + r*sin(angleList);

temp = patch(xVec,yVec,c);
set(temp, 'EdgeAlpha',0.1);

end %plotCircle