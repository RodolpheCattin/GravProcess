function [varargout] = convertContainedStringsToChars(varargin)
%convertContainedStringsToChars Convert string arrays at any level of cell array or structure
%   B = convertContainedStringsToChars(A) converts string elements in a
%   string array, cell array, or structure. If A has any other data type,
%   then the function returns A unaltered.
%  
%   The function converts elements using the rules defined in
%   convertStringsToChars.
% 
%   The elements of a cell array can be any data type, including a cell
%   array or structure. Similarly, the value of a structure field can be
%   any datatype, including a cell array or structure.  The function
%   converts strings at every level of A.
%
%   [A,B,C,...] = convertContainedStringsToChars(X,Y,Z,...) supports
%   multiple inputs and outputs.
%
%   NOTE: The primary purpose of convertContainedStringsToChars is to make
%   existing code accept contained string inputs. A common pattern is to
%   pass the entire input argument list in and out of
%   convertContainedStringsToChars.
% 
%   NOTE: convertContainedStringsToChar was introduced in R2018b. To make 
%   existing code accept contained string inputs in R2018a and previous 
%   releases, include this file with your code.
%
%   Examples:
%
%      a = convertContainedStringsToChars({'matryoshka'; ...
%                                          4; "Russian nesting doll"; ...
%                                          ["little", "matron"]})
%  
%      a =
%         
%        4x1 cell array
%               
%          {'matryoshka'          }
%          {[                   4]}
%          {'Russian nesting doll'}
%          {1x2 cell              }
%
%   See also ISCHAR, ISCELLSTR, VARARGIN, ISA, CONVERTSTRINGSTOCHARS.

%   Copyright 2018 The MathWorks, Inc.

    if nargin ~= nargout && ~(nargout == 0 && nargin ==1)
        error('The number of outputs must match the number of inputs.');
    end

    for i=1:nargin
        
        value = varargin{i};
        
        if iscell(value)
            [value{1:numel(value)}] = convertContainedStringsToChars(value{:});
        elseif isstruct(value)
            fields = fieldnames(value);
            for j = 1:numel(fields)
                field = fields{j};
               [value.(field)] = convertContainedStringsToChars(value.(field));
            end            
        else
            value = convertString(value);
        end
        
        varargin{i} = value;
    end
    varargout = varargin;
end

function value = convertString(value)

    if isa(value,'string')
        
        value(ismissing(value)) = '';

        if isscalar(value)
            value = char(value);
        else
            value = cellstr(value);
        end
    end
end