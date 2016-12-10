
	-- Code here runs when the scene is first created but has not yet appeared on screen
  local background = display.newImageRect("images/paper.png", 1200, 1200)
 -- local hangmanPost = display.newImageRect( "images/0post.png", 200, 200)
  --hangmanPost.x = display.contentCenterX-165
 --hangmanPost.y = display.contentCenterY+55

  local startX = -35
  local endX = 515
  local startY = 10
  local endY = 310
  local aStartX = 0
  local aStartY = 20
  local width = 480; local height = 320;
  local r = 0
  local g = 0
  local b = 0
  local hasWon=false
  print("back at hangman")
  local magicword = "CAT"
  lines = {string.len(magicword)}
  newLetter = {}
  local initialX = display.contentWidth - 200
  local startLetters = initialX
  local yCoord = startY + 10
  local hangCount = 1
  local correctGuesses = 0
  local winnerText
--stuff for the composer
  --composer.removeScene("hangman")
  --composer.gotoScene( "hangman" )

--*****************************************************************************
--pulling in global variables from the composer
  -- print("global var magicword is "..composer.getVariable( "magicword" ))
  -- print(composer.getVariable( "lines" )[1])
  -- --draw lines for magicword revealing length
  -- lines = composer.getVariable( "lines")
  --
  -- local magicword = composer.getVariable( "magicword" )

  --print(composer.getSceneName( "current" ))
  --print(composer.getSceneName( "previous" ))

  --******************************************************************************
  --load hangman images into an array that can be displayed on wrong guesses, & set size
  --******************************************************************************
  --hangman = {}
  --hangman[1] = display.newImageRect( "images/0post.png", 200, 200)
  --hangman[2] = display.newImageRect( "images/1head.png", 200, 200)
  --hangman[3] = display.newImageRect( "images/2body.png", 200, 200)
  --hangman[4] = display.newImageRect( "images/3rightArm.png", 200, 200)
  --hangman[5] = display.newImageRect( "images/4leftArm.png", 200, 200)
  --hangman[6] = display.newImageRect( "images/5leftLeg.png", 200, 200)
  --hangman[7] = display.newImageRect( "images/6rightLeg.png", 200, 200)


  --align the hangman images on the screen
  --for i = 2, table.getn(hangman), 1 do
  --		hangman[i].x = display.contentCenterX - 165
  --		hangman[i].y = display.contentCenterY + 55
  --		hangman[i].alpha = 0
  --end

    local hangmanGroup = display.newGroup()
    local options = {
    width = 315,
    height = 315,
    numFrames = 9,
    sheetContentWidth = 945,
    sheetContentHeight = 945
  }


  local imageSheet = graphics.newImageSheet("images/sprite.png", options)

  local sequenceData ={
                       {name = "post", start = 1, count = 1},
                       {name = "head", start = 2, count = 1},
                       {name = "body", start = 3, count = 1},
                       {name = "leftArm", start = 4, count = 1},
                       {name = "rightArm", start = 5, count = 1},
                       {name = "leftLeg", start = 6, count = 1},
                       {name = "rightLeg", start = 7, count = 1}
  }
  local hangmanFrames = {"head","body","leftArm","rightArm","leftLeg","rightLeg"}
  local hangman = display.newSprite(imageSheet, sequenceData)
  hangman.x = display.contentCenterX-125
  hangman.y = display.contentCenterY
  hangman:setSequence("post")
  hangman:play()
  --initialize the alphabet of the actual letter strings
  alphabet = {}
  alphabet = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P",
  "Q","R","S","T","U","V","W","X","Y","Z"}

  --******************************************************************************
  --CREATE MAGICWORD DISPLAY GRID
  --change alpha to 1 when letters selected from alphabet
  --******************************************************************************
  magicCopy = {}
  printOut = {}
  local magicX = 50
  --local result


  for i = 1, string.len(magicword), 1 do
  	magicCopy[i] = string.sub(magicword, i, i)
  	printOut[i] = display.newText(magicword:sub(i,i), magicX, 255, "drewsFont.ttf", 35 )
  	lines[i] = display.newLine(magicX-15, 273, magicX+15, 273)
    lines[i]:setStrokeColor(1,0,0)
    lines[i].strokeWidth = 3

    magicX = magicX + 35
  	printOut[i].alpha = 0

  end--for length of magicword add display text objects

  local resetButton

--all this was broken
  -- local function reset()
  --   local resetButton = display.newImageRect( "images/resetButton.png",100,50 )
  --   resetButton.x = display.contentCenterX
  --   resetButton.y = display.contentCenterY +50
  --   end--reset()



  local function resetListener( event )
      if (event.phase == "began") then

        --not sure if this is being used...
        --composer.setVariable( "magicword", "" )

        --this was part of the resetListener
        --composer.setVariable( "lines", {} )
        print("reset listener was triggered")
        --lines={}

        --composer.removeScene("hangman")
        --composer.gotoScene( "chooseWord" )
        --print ("Reset button event triggered! It should work now...")
      end -- if event began
  end --resetListener(event)


local function fillLetters( letter )
  newLetter[letter].alpha = 1
  newLetter[letter]:setFillColor(1,0,0)
end

local function winGame()
  hasWon=true
  winnerText = display.newText("WINNER!", display.contentCenterX,
  display.contentCenterY, "drewsFont.ttf", 55)
  winnerText:setFillColor(1,0,0)
  resetButton = display.newImageRect( "images/resetButton.png",100,50 )
  resetButton.x = display.contentCenterX
  resetButton.y = display.contentCenterY +50
  resetButton:addEventListener("touch", resetListener)
end

local function fillWord( letter )
  printOut[letter].alpha = 1
  printOut[letter]:setFillColor(0,0,1)
  --correctGuesses = 0
  printOut[letter].alpha = 1
  printOut[letter]:setFillColor(0,0,1)
  correctGuesses = 0

end
--this one didn't work for some reason:
-- local function ifWinner()
--     for i = 1, table.getn(printOut), 1 do
--         if (printOut[i].alpha == 1) then
--             correctGuesses = correctGuesses + 1
--         end
--     end --for length of printOut
-- end --check if winner
--so try, try again...
function checkIfWon()

  for i = 1, table.getn(printOut), 1 do
        if (printOut[i].alpha == 1) then
          correctGuesses = correctGuesses + 1
        end
        --ifWinner()
        if (correctGuesses == table.getn(printOut)) then
            winGame()
        end
  end--for length of printOut
end


  --******************************************************************************
  --CREATE ALPHABET GRID for touch interaction with copy,
  --then compare original array to magic word
  --******************************************************************************

  --for loop to set alphabet letters on screen with event listeners
  for i = 1, 26, 1 do
  		 if (i % 7 == 0 ) then
  			 	yCoord = yCoord + 40
  			 	startLetters = initialX
  		 end

  		newLetter[i] = display.newText(alphabet[i], startLetters, yCoord,
			"drewsFont.ttf", 35 )
  		newLetter[i]:setFillColor( 0, 0, 0 )
  		newLetter[i].alpha = .25
  		local index

  		local outputX = 100
  		local function letterListener( event )

  				if ( event.phase == "began" and newLetter[i].alpha ~= 1 and hangCount < 8 and hasWon==false) then
                  fillLetters(i)

  					    if (string.find(magicword,alphabet[i])~=nil) then

  					        for j = 1, string.len(magicword),1 do
  					        	if (alphabet[i]==string.sub(magicword,j,j)) then
                        fillWord( j )
  					        		-- printOut[j].alpha = 1
  											-- printOut[j]:setFillColor(0,0,1)
  										  -- correctGuesses = 0
                        checkIfWon()

  					        	end --if letter matches index j of magicword
  					        end--for j, length of magicword

  					    elseif (hangCount < 8) then
  					    	hangman:setSequence(hangmanFrames[hangCount])
                  hangman:play()

                  --hangman[hangCount].alpha = 1

                  hangCount = hangCount + 1

                  print ("Hang count is: "..hangCount)

                  if (hangCount > 6 and gameOver==nil) then
  					    		local gameOver = display.newText("GAME OVER!", display.contentCenterX,
  					    			display.contentCenterY, "drewsFont.ttf", 55)
  					    		gameOver:setFillColor(1,0,0)
                    --reset()
  					    	end--if hangCount > 7, gameOver

                end--end if matches a letter in magicword
  			    end--if event began

  			    return true
  		end--letterListener( event )

  		newLetter[i]:addEventListener( "touch", letterListener )
  		startLetters = startLetters + 30

  end--for length of alphabet



--end--scene:create(event)

--
-- -- show()
-- function scene:show( event )
--
-- 	local sceneGroup = self.view
-- 	local phase = event.phase
--
-- 	if ( phase == "will" ) then
-- 		-- Code here runs when the scene is still off screen (but is about to come on screen)
--
-- 	elseif ( phase == "did" ) then
-- 		-- Code here runs when the scene is entirely on screen
--     --print("showing hangman")
--
-- 	end
-- end--scene:show

--
-- -- hide()
-- function scene:hide( event )
--
-- 	local sceneGroup = self.view
-- 	local phase = event.phase
--
-- 	if ( phase == "will" ) then
--
-- 	elseif ( phase == "did" ) then
-- 		-- Code here runs immediately after the scene goes entirely off screen
--
-- 	end
-- end--scene:hide
