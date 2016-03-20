function textOnly = rmHyperlink(thisEntry)
% get text entry without hyperlink
%
% Input:
%   thisEntry   cell as returned by regexp token match in some previous step
%
% Output:
%   textOnly    char of text with hyperlink excluded
%
% There can me multiple cases:
% - empty string
% - complete string is text within <a> tags
% - no <a> tags at all, pure text
% - text inside of <a> tags and text before or after

% no text at all
if isempty(thisEntry{1})
    textOnly = '';
else
    % try to match text inside of hyperlink
    inATokens = regexp(thisEntry{1}, ...
        '<a.*>(.*?)</a>', 'tokens', 'all');
    
    % special case: no hyperlink at all
    if isempty(inATokens)
        textOnly = thisEntry{1};
    else
        % special case: complete entry is hyperlink
        fullMatch = regexp(thisEntry{1}, ...
            '^<a.*>.*?</a>$', 'match');
        
        % is full match found?
        isFullMatch = ~isempty(fullMatch);
        
        if isFullMatch
            textOnly = inATokens{1}{1};
        else
            % find text parts outside of <a> tags
            [~, outATokens] = regexp(thisEntry{1}, ...
                '<a.*>.*</a>', 'match', 'split');
            textOnly = [outATokens{1} inATokens{1}{1} outATokens{2}];
        end
    end
end