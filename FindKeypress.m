function [keyNames, keyNumbers] = FindKeypress

WaitSecs(.2);
keyPressed = 0;

while keyPressed == 0
    WaitSecs(.1);
    [KeyIsDown, ~, KeyCode] = KbCheck;
    if KeyIsDown == 1
        keyPressed = 1;
        keyNames=KbName(KeyCode);

        numberOfKeys = sum(KeyCode);
        keyNumbers = zeros(1, numberOfKeys);

        numberOfMatches = 0;
        for i = 1:length(KeyCode)
            if KeyCode(i) == 1
                numberOfMatches = numberOfMatches + 1;
                keyNumbers(numberOfMatches) = i;
            end
        end
    end
end