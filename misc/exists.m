function varargout=exists(varargin)
%cos I keep typing exists instead of exist
warning('you really mean exist')

varargout={exist(varargin{:})};

return