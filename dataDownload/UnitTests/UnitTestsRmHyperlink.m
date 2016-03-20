classdef UnitTestsRmHyperlink < matlab.unittest.TestCase
    % Unit tests for function rmHyperlink
    methods(TestClassSetup)
        function addFuncToPath(testCase)
           addpath('../src/') 
        end
    end
    methods (Test)
        %% test string column vectors
        function testEmptyString(testCase)
            thisEntry = {''};
            expOut = '';
            actOut = rmHyperlink(thisEntry);
            testCase.verifyEqual(actOut, expOut);
        end
        
        function testHyperlinkOnly(testCase)
            thisEntry = {'<a rel="nofollow" class="external text" href="http://www.sec.gov/cgi-bin/browse-edgar?CIK=MMM&amp;action=getcompany">reports</a>'};
            expOut = 'reports';
            actOut = rmHyperlink(thisEntry);
            testCase.verifyEqual(actOut, expOut);
        end
        
        function testTextOnly(testCase)
            thisEntry = {'Hello world!'};
            expOut = 'Hello world!';
            actOut = rmHyperlink(thisEntry);
            testCase.verifyEqual(actOut, expOut);
        end

        function testTextAfter(testCase)
            thisEntry = {'<a href="/wiki/Global_Industry_Classification_Standard" title="Global Industry Classification Standard">GICS</a> Sector'};
            expOut = 'GICS Sector';
            actOut = rmHyperlink(thisEntry);
            testCase.verifyEqual(actOut, expOut);
        end

        function testTextBefore(testCase)
            thisEntry = {'Sector <a href="/wiki/Global_Industry_Classification_Standard" title="Global Industry Classification Standard">GICS</a>'};
            expOut = 'Sector GICS';
            actOut = rmHyperlink(thisEntry);
            testCase.verifyEqual(actOut, expOut);
        end

        function testTextBeforeAndAfter(testCase)
            thisEntry = {'Sector <a href="/wiki/Global_Industry_Classification_Standard" title="Global Industry Classification Standard">GICS</a> sector'};
            expOut = 'Sector GICS sector';
            actOut = rmHyperlink(thisEntry);
            testCase.verifyEqual(actOut, expOut);
        end

    end
end