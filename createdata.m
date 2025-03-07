% Assume you have some data and parsing has taken place
%
%  Ultimately, for each user, it looks like a 3 x 6 matrix
%  [lat long time]
%  [lat long time]
%  [lat long time]
%  [lat long time]
%  [lat long time]
%  [lat long time]
%
% For now, we are using instamapper data
%
%
% We want to reshape it into a row vector without the times **assume they
% are the same for now** and keep the times in the first row


% clc
% clear all
% close all
% numusers = 60;

function [coord, m] = createdata(numusers)

%This is a function that loads user generated GPS data collected by
%Instamapper and then adds noise and duplicates it to get about 30 data
%sets

load vince1.mat
load vince2.mat

%Lat1, Long1, Lat2, Long2 -- all the same
m = size(Lat1,2);


%We want to approximate about 60 users. For now, multiple Vince1 and Vince2
%by 30 and add noise

disp('line 40')
for i = 1:numusers/2
    data(1 + 4*(i - 1), :) = Lat1 + .0001*randn(1,m);
    data(2 + 4*(i - 1), :) = Long1 + .0001*randn(1,m);
    
    data(3 + 4*(i - 1), :) = Lat2 + .0001*randn(1,m);
    data(4 + 4*(i - 1), :) = Long2 + .0001*randn(1,m); 
end

%And now let's turn 99 data points into approximately 20160 (two weeks) by multiplying by
%200 + 1

disp('line 51')
datatemp = data;
for i = 1:200
    datatemp = [datatemp ; data + (.0001 * randn(size(data,1), size(data,2)))];
end

data = datatemp;

%% Ok, now we have some data. We don't care about time or anything like that, so reshape it into a massive set of (X,Y) coordinates

disp('line 61')
coord = [];
for i = 1:size(data,1)/2
    new(1:2,:) = [data(2*i-1,:) ; data(2*i,:)];    
    coord = [coord new];
end

coord = coord';
% Have to switch columns for (x,y) mix-up
coordtemp = coord;
coord(:,1) = coordtemp(:,2);
coord(:,2) = coordtemp(:,1);

end