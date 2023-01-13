function alphaTable = MultipleComparisonCorrection(baseAlpha, pValues, correctionMethod)

% baseAlpha = the base alpha value for 1 test. (In psychology this is usually .05)

% pValues = a table/array object of you tests' p-values. This can be the number of tests instead, 
%           but this will not give the correct order of alpha levels for the "Holm" or "Hochberg" tests. 
%           The alpha levels will instead be ordered from smallest -> largest p-value if number of tests is used instead of a table/array.

% correctionMethod = the multiple comparison correction method you want to use. Can be "None", "Bonferroni", "Holm", or "Hochberg".

% Example:      pValueArray = [.351, .011, .002, .049]; 
%               alphaValues = MultipleComparisonCorrection(.05, pValueArray, "Hochberg");

% Example 2:    alphaValues = MultipleComparisonCorrection(.01, 4, "Bonferroni"); 

if istable(pValues) == 1                %Converts p values into an array format if the input is a table
    pValues = table2array(pValues);
end

if isa(pValues, 'double') == 1 && length(pValues) == 1 && pValues > 1
    numberOfTests = pValues;
    pInputType = 2;
else
    numberOfTests = length(pValues);
    pInputType = 1;
end
%Counts number of tests using the length of the p value array

alphaTable = zeros(1, numberOfTests);   %Creates alpha value table with the same number of rows as tests to input alpha vaalues

if correctionMethod == "None"                       %If correction method is "None", the inputted alpha is applied to all columns
    alpha = baseAlpha;
    alphaTable = alphaTable + alpha;

elseif correctionMethod == "Bonferroni"             %If correction method is "Bonferroni", (inputted alpha / number of trials) is applied to all columns
    alpha = baseAlpha ./ numberOfTests;
    alphaTable = alphaTable + alpha;

elseif correctionMethod == "Holm" || correctionMethod == "Hochberg"     %Uses the following method if correction method is either "Holm" or "Hochberg"

    if correctionMethod == "Holm"                                       %For "Holm", the largest p-value is assigned the largest alpha; the opposite is true for Hochberg
        rankDirection = 'descend';
    elseif correctionMethod == "Hochberg"                               %Assigns the direction of alpha values depending on whether "Holm" or "Hochberg" is selected
        rankDirection = 'ascend';
    end

    hAlphaTable = zeros(1, numberOfTests);      %Creates temporary table for alpha values
    
    for i = 1: numberOfTests
       hAlphaTable(1,i) = baseAlpha ./ i;       %Fills temporary table with the alpha values by dividing inptted alpha by the row number
    end

    if pInputType == 1   
       [~,pRank] = sort(pValues, rankDirection);    %Sorts alpha values using the size of the p values. Direction depends on test type.
       rank = 1:length(pValues);
       rank(pRank) = rank;
    elseif pInputType == 2
       rank = 1:pValues;
       if correctionMethod == "Holm"
           rank = flip(rank,2);
       end
       fprintf('NOTE: Alpha values will be saved in order of smallest -> largest p-value.\n')
    else
       fprintf('Error of input type for pValues! Please check you input.\n')
    end


    for i = 1:numberOfTests                              %Uses alpha values in temporary table and rank order in 'rank' object.                    
        for j = 1:numberOfTests                          %Checks each rank in turn (i) with each row of the 'rank' object (j). 
            if rank(j) == i                              %Looks for the row when the current rank (i) matches the rank in the 'rank' object (j).
                alphaTable(1,j) = hAlphaTable(1,i);      %When they match, assigns the alpha value from the temporary table (row i) to the output table (row j).   
            end
        end
    end


else
    fprintf('Please enter "None", "Bonferroni", "Holm", or "Hochberg" for the Correction Method Variable!\n')    %Error message if not entered correctly
    for i = 1:numberOfTests                                                                                      %Sets all alpha values to NaN
        alphaTable(1,i) = NaN;
    end
end   

end