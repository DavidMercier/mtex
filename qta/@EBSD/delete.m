function ebsd = delete(ebsd,id)
% delete points from EBSD data
%
%% Syntax  
% ebsd  = delete(ebsd,id)
% ebsd  = delete(ebsd,get(ebsd,'phase')~=1)
%
%% Input
%  ebsd   - @EBSD
%  id   - index set 
%
%% Output
%  ebsd - @EBSD
%
%% See also
% EBSD/get EBSD_index

if isa(id,'logical'), id = find(id);end
cs = cumsum([0,sampleSize(ebsd)]);

for i= 1:length(ebsd)
	
	idi = id((id > cs(i)) & (id<=cs(i+1)));
  if ~isempty(ebsd(i).xy), ebsd(i).xy(idi-cs(i),:) = [];end
  %if ~isempty(ebsd(i).phase), ebsd(i).phase(idi-cs(i)) = [];end
	ebsd(i).orientations = delete(ebsd(i).orientations,idi-cs(i));
end