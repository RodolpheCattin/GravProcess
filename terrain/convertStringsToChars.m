function [varargout] = convertStringsToChars(varargin)
%convertStringsToChars Convert string arrays to character arrays and leave others unaltered.
%   B = convertStringsToChars(A) converts A to a character array if A is a
%   string array. If A is a string scalar, then B is a character vector. If
%   A is a string array, then B is a cell array of character vectors.  If A
%   has any other data type, then convertStringsToChars returns A
%   unaltered.
%
%   [A,B,C,...] = convertStringsToChars(X,Y,Z,...) supports multiple inputs
%   and outputs. This is especially useful when functions use varargin, for
%   example functions that have name-value parameter arguments specified by
%   varargin.
%
%   NOTE: The primary purpose of convertStringsToChars is to make existing
%   code accept string inputs. A common pattern is to pass the entire input
%   argument list in and out of convertStringsToChars.
%
%   NOTE: <missing> string inputs are converted into 0x0 char, i.e. ''.
%
%   NOTE: convertStringsToChars was introduced in R2017b. To make existing 
%   code accept string inputs in R2017a and previous releases, include 
%   this file with your code.
%
%   Examples:
%       a = convertStringsToChars("Luggage combination")
%
%       a =                     
%           'Luggage combination'               
%
%
%       % A common way to use this is:
%       [varargin{:}] = convertStringsToChars(varargin{:})
%
%
%       [a,b,c,d] = convertStringsToChars('one',2,"three",["four","five"])
%
%       a =                     
%           'one'               
%       b =                     
%            2                  
%       c =                     
%           'three'               
%       d =                     
%         1x2 cell array        
%           'four'    'five'      
%
%   See also ISCHAR, ISCELLSTR, VARARGIN, ISA, CONVERTCONTAINEDSTRINGSTOCHARS.

%   Copyright 2018 The MathWorks, Inc.

    if nargin ~= nargout && ~(nargout == 0 && nargin ==1)
        error('The number of outputs must match the number of inputs.');
    end

    for i=1:nargin
        varargin{i} = convertString(varargin{i});
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