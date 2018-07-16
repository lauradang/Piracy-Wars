% Name: Laura Dang
% Date: Dec.20/15
% Class: ICS2O1
% Description: this program runs the game piracy wars

View.Set ("graphics:1000;600,nobuttonbar,nocursor")

% Variable Description
% DVD_X     this represents the x coordinates of the pirated DVD
% DVD_Y     this represents the y coordinates of the pirated DVD
% x_goodguy this represents the x coordinates of the good guy
% y_goodguy this represents the y coordinates of the good guy
% ammo      this represents the number of ammo the player accumulates
% lives     this represents the number of lives remaining that the user has
% direction_badguy  this represents the direction that the badguy is travelling
% score     this represents the users cumulative score
% bullet_x  this represents the x coordinate of the bullet
% bullet_y  this represents the y coordinate of the bullet
% direction this represents the direction of the bullet
% item_chance   this represents the item's chances of appearing
% dvds_needed   this represents the number of dvds needed to pass to the next level
% chars     this represents the keyboard variables
% user_input   this represents the space bar input variable
% x_badguy  this represents the x coordinates of the bad guy
% y_badguy  this represents the y coordinates of the bad guy
% badguy_colour this represents what colour the bad guy is
% badguy_eyecolour  this represents the colour of the bad guy's eyes
% chance_badguy    this represents the random numbers that decide how the bad guy will move
% ammo_x    this represents the x coordinates of the ammo
% ammo_y    this represents the y coordinates of the ammo
% copyright_x   this represents the x coordinates of the copyright material
% copyright_y   this represents the y coordinates of the copyright material
% Left      this represents the keyboard command when pressing the left arrow key
% Right     this represents the keyboard command when pressing the right arrow key
% Up        this represents the keyboard command when pressing the up arrow key
% Down      this represents the keyboard command when pressing the down arrow key
% shooting  this represents whether or not the bullet has been shot
% badguy_alive  this represents whether or not the badguy is on the game set or not
% dvd_present   this represents if the dvd has been picked up by the user or not
% copyright     this represents if the copyrighted material has been picked up by the user or not
% ammo_alive    this represents if the ammo has been picked up by the user or not
% celebrate_x   this represents the x coordinates of the coloured dots in the "win" scene
% celebrate_y   this represents the x coordinates of the coloured dots in the "win" scene
% font      this represents the font that draws all the words in the actual game
% font1     this represents the font that draws the small font in the menu
% font2     this represents the font that draws the word "space" on the spacebar in the instruction
% font3     this represents the font that draws the words in the instructions
% font4     this represents the font that draws all the main titles in the game
% pirated_logo  this represents the picture that was imported into the programs
% mouse_x   this represents the x coordinates of the mouse
% mouse_y   this represents the y coordinates of the mouse
% button    this represents the mouse button
% menu      this represents the case for the menu

% Variable Declaration
const DVD_X : array 1 .. 14 of int := init (119, 881, 119, 881, 218, 775, 775, 217, 414, 586, 591, 410, 413, 590)
const DVD_Y : array 1 .. 14 of int := init (532, 532, 172, 172, 430, 430, 271, 271, 370, 370, 172, 172, 532, 532)
var x_goodguy, y_goodguy, ammo, lives : int
var direction_badguy, score, bullet_x, bullet_y, direction, item_chance, dvds_needed : int := 0
var chars, user_input : array char of boolean
var x_badguy, y_badguy, badguy_colour, badguy_eyecolour, chance_badguy : array 1 .. 14 of int
var ammo_x, ammo_y, copyright_x, copyright_y : array 1 .. 2 of int
var Left, Right, Up, Down, shooting : boolean := false
var badguy_alive, dvd_present : array 1 .. 14 of boolean
var copyright, ammo_alive : array 1 .. 3 of boolean
var celebrate_x, celebrate_y : array 1 .. 800 of int
var font := Font.New ("Fixedsys:17")
var font1 := Font.New ("Fixedsys:40")
var font2 := Font.New ("Sans Serif:13")
var font3 := Font.New ("Fixedsys:18")
var font4 := Font.New ("Fixedsys:120")
var pirated_logo : int := Pic.FileNew ("pirated.jpg")
var mouse_x, mouse_y, button, menu : int

% initializes variables
for i : 1 .. 3
    copyright (i) := false
    ammo_alive (i) := false
end for
dvd_present (1) := true
badguy_alive (1) := false
x_goodguy := 500
y_goodguy := 70
ammo := 3
lives := 3
x_badguy (1) := 0
y_badguy (1) := 0

% drawing box (menu)
proc boxes (x : int)
    Draw.FillBox (x + 56, 200, x + 340, 450, white)
    Draw.FillBox (x + 56, 370, x + 340, 450, 54)
end boxes

% procedure to draw arrow keys (menu)
proc arrowkeys (x, y : int)
    Draw.Box (419 + x, 240 + y, 469 + x, 290 + y, black)
end arrowkeys

% procedure to draw left and right arrows (menu)
proc arrows_left_right (x : int)
    Draw.ThickLine (433 + x, 265, 455 + x, 265, 2, black)
end arrows_left_right

% procedure to draw up and down arrows (menu)
proc arrows_up_down (y : int)
    Draw.ThickLine (493, 250 + y, 493, 275 + y, 2, black)
end arrows_up_down

% erases badguy when shot
proc erase_enemy (x : int)
    if Math.Distance (bullet_x, bullet_y, x_badguy (x), y_badguy (x)) < 5 and shooting = true then
	shooting := false
	x_badguy (x) := 0
	y_badguy (x) := 0
	score += 25
    end if
end erase_enemy

% goodguy movements (up)
proc goodguy_up
    % calls keyboard commands (keys and space)
    Input.KeyDown (chars)
    Input.KeyDown (user_input)

    % gives user more space to turn onto a platform and ensures user stays within wall collision boundaries
    if chars (KEY_UP_ARROW) and x_goodguy < 326 and x_goodguy > 320 and y_goodguy = 532 then
	x_goodguy := 320
	% gives user leeway when moving up from bottom middle
    elsif chars (KEY_UP_ARROW) and x_goodguy > 485 and x_goodguy < 509 and y_goodguy = 70 then
	x_goodguy := 500
	% gives user leeway when moving up from bottom right
    elsif chars (KEY_UP_ARROW) and x_goodguy > 675 and x_goodguy < 681 and y_goodguy = 70 then
	x_goodguy := 680
	% gives user leeway when moving left from 2nd bottom platform middle
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 500 and y_goodguy > 165 and y_goodguy < 179 then
	y_goodguy := 172
	% gives user leeway when moving right from 2nd bottom platform middle
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 500 and y_goodguy > 165 and y_goodguy < 200 then
	y_goodguy := 172
	% gives user leeway when moving down from 2nd bottom platform middle
    elsif chars (KEY_DOWN_ARROW) and x_goodguy > 485 and x_goodguy < 509 and y_goodguy = 172 then
	x_goodguy := 500
	% gives user leeway when moving up from 2nd bottom platform middle
    elsif chars (KEY_UP_ARROW) and x_goodguy > 485 and x_goodguy < 509 and y_goodguy = 172 then
	x_goodguy := 500
	% gives user leeway when moving left from 2nd bottom platform, 2nd to the left
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 320 and y_goodguy > 165 and y_goodguy < 179 then
	y_goodguy := 172
	% gives user leeway when moving right from 2nd bottom platform, 2nd to the left
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 320 and y_goodguy > 165 and y_goodguy < 200 then
	y_goodguy := 172
	% gives user leeway when moving down from 2nd bottom platform, 2nd to the left
    elsif chars (KEY_DOWN_ARROW) and x_goodguy > 305 and x_goodguy < 335 and y_goodguy = 172 then
	x_goodguy := 320
	% gives user leeway when moving up from 2nd bottom platform, 2nd to the left
    elsif chars (KEY_UP_ARROW) and x_goodguy > 305 and x_goodguy < 335 and y_goodguy = 172 then
	x_goodguy := 320
	% gives user leeway when moving up from 2nd bottom platform, 1st to the left
    elsif chars (KEY_UP_ARROW) and x_goodguy < 134 and x_goodguy < 118 then
	x_goodguy := 119
	% gives user leeway when moving right from 3rd bottom platform, 1st to the left
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 119 and y_goodguy < 286 and y_goodguy > 255 then
	y_goodguy := 271
	% gives user leeway when moving right from 2nd platform to the left
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 119 and y_goodguy < 445 and y_goodguy > 415 then
	y_goodguy := 430
	% gives user leeway when moving left from 2nd platform, 2nd column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 320 and y_goodguy < 445 and y_goodguy > 415 then
	y_goodguy := 430
	% gives user leeway when moving down from 1st platform, 2nd column
    elsif chars (KEY_DOWN_ARROW) and x_goodguy < 335 and x_goodguy > 305 and y_goodguy = 532 then
	x_goodguy := 320
	% gives user leeway when moving right from 3rd platform, 2nd column
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 320 and y_goodguy < 385 and y_goodguy > 355 then
	y_goodguy := 370
	% gives user leeway when moving left from 3rd platform, 3rd column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 500 and y_goodguy < 385 and y_goodguy > 355 then
	y_goodguy := 370
	% gives user leeway when moving right from 3rd platform, 3rd column
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 500 and y_goodguy < 385 and y_goodguy > 355 then
	y_goodguy := 370
	% gives user leeway when moving up from 3rd platform, 3rd column
    elsif chars (KEY_UP_ARROW) and x_goodguy < 515 and x_goodguy > 485 and y_goodguy = 370 then
	x_goodguy := 500
	% gives user leeway when moving down from 3rd platform, 3rd column
    elsif chars (KEY_DOWN_ARROW) and x_goodguy < 515 and x_goodguy > 485 and y_goodguy = 370 then
	x_goodguy := 500
	% gives user leeway when moving down from top of 3rd column
    elsif chars (KEY_DOWN_ARROW) and x_goodguy < 515 and x_goodguy > 485 and y_goodguy = 532 then
	x_goodguy := 500
	% gives user leeway when moving down from top of 4th column
    elsif chars (KEY_DOWN_ARROW) and x_goodguy < 695 and x_goodguy > 665 and y_goodguy = 532 then
	x_goodguy := 680
	% gives user leeway when moving left from 3rd platform, 4th column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 680 and y_goodguy < 385 and y_goodguy > 355 then
	y_goodguy := 370
	% gives user leeway when moving left from 4th platform, 2nd column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 320 and y_goodguy < 286 and y_goodguy > 256 then
	y_goodguy := 271
	% gives user leeway when moving left from 2nd bottom platform, 4th column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 680 and y_goodguy < 187 and y_goodguy > 157 then
	y_goodguy := 172
	% gives user leeway when moving right from 2nd bottom platform, 4th column
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 680 and y_goodguy < 187 and y_goodguy > 157 then
	y_goodguy := 172
	% gives user leeway when moving up from 2nd bottom platform, 4th column
    elsif chars (KEY_UP_ARROW) and y_goodguy = 172 and x_goodguy < 695 and x_goodguy > 665 then
	x_goodguy := 680
	% gives user leeway when moving down from 2nd bottom platform, 4th column
    elsif chars (KEY_DOWN_ARROW) and y_goodguy = 172 and x_goodguy < 695 and x_goodguy > 665 then
	x_goodguy := 680
	% gives user leeway when moving right from 4th platform, 4th column
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 680 and y_goodguy < 286 and y_goodguy > 256 then
	y_goodguy := 271
	% gives user leeway when moving right from 3rd platform, 4th column
    elsif chars (KEY_RIGHT_ARROW) and x_goodguy = 680 and y_goodguy < 445 and y_goodguy > 415 then
	y_goodguy := 430
	% gives user leeway when moving left from 2nd platform, 5th column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 881 and y_goodguy < 187 and y_goodguy > 157 then
	y_goodguy := 172
	% gives user leeway when moving left from 3rd platform, 5th column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 881 and y_goodguy < 445 and y_goodguy > 415 then
	y_goodguy := 430
	% gives user leeway when moving left from 4th platform, 5th column
    elsif chars (KEY_LEFT_ARROW) and x_goodguy = 881 and y_goodguy < 286 and y_goodguy > 256 then
	y_goodguy := 271
	% ensures goodguy stays in wall collision boundaries
    elsif x_goodguy = 882 then
	x_goodguy := 881
    elsif x_goodguy = 679 then
	x_goodguy := 680
    elsif x_goodguy = 118 then
	x_goodguy := 119
    elsif x_goodguy = 321 then
	x_goodguy := 320
    elsif y_goodguy = 533 then
	y_goodguy := 532
    elsif y_goodguy = 171 then
	y_goodguy := 172
    end if

    % checks boundaries and walls to see if user can move up
    if chars (KEY_UP_ARROW) and x_goodguy = 320 and y_goodguy < 532 then
	y_goodguy := y_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy + 1
	    bullet_x := x_goodguy
	    direction := 1
	    % if no more ammo left, user cannot shoot
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_UP_ARROW) and x_goodguy = 680 and y_goodguy < 532 then
	y_goodguy := y_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy + 1
	    bullet_x := x_goodguy
	    direction := 1
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_UP_ARROW) and x_goodguy = 500 and y_goodguy < 532 then
	y_goodguy := y_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy + 1
	    bullet_x := x_goodguy
	    direction := 1
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_UP_ARROW) and x_goodguy = 119 and y_goodguy < 532 then
	y_goodguy := y_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy + 1
	    bullet_x := x_goodguy
	    direction := 1
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_UP_ARROW) and x_goodguy = 881 and y_goodguy < 532 then
	y_goodguy := y_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy + 1
	    bullet_x := x_goodguy
	    direction := 1
	elsif user_input (chr (32)) and ammo = 0 then
	end if
    end if

    % checks if bullet is within shooting parameters to be able to keep advancing bullet forward
    if direction = 1 and bullet_y < maxy and shooting = true then
	bullet_y := bullet_y + 6
    end if

    % checks if bullet is out of game parameters to stop bullet
    if bullet_y >= maxy then
	shooting := false
    end if
end goodguy_up

% goodguy movements right
proc goodguy_right

    % checks boundaries and walls to see if user can move right
    if chars (KEY_RIGHT_ARROW) and y_goodguy = 70 and x_goodguy <= 679 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 172 and x_goodguy <= 880 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 271 and x_goodguy >= 680 and x_goodguy <= 880 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 370 and x_goodguy <= 679 and x_goodguy >= 313 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 271 and x_goodguy >= 119 and x_goodguy <= 319 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 430 and x_goodguy >= 119 and x_goodguy <= 319 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 430 and x_goodguy >= 680 and x_goodguy <= 880 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_RIGHT_ARROW) and y_goodguy = 532 and x_goodguy >= 119 and x_goodguy < 881 then
	x_goodguy := x_goodguy + 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy + 1
	    direction := 2
	elsif user_input (chr (32)) and ammo = 0 then
	end if
    end if

    % checks if bullet is within shooting parameters to be able to keep advancing bullet forward
    if direction = 2 and bullet_x < maxx and shooting = true then
	bullet_x := bullet_x + 6
    end if

    % checks if bullet is out of game parameters to stop bullet
    if bullet_x >= maxx then
	shooting := false
    end if
end goodguy_right

% goodguy movements lefts
proc goodguy_left

    % checks boundaries and walls to see if user can move left
    if chars (KEY_LEFT_ARROW) and y_goodguy = 70 and x_goodguy > 320 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and y_goodguy = 172 and x_goodguy >= 120 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and x_goodguy <= 881 and y_goodguy = 271 and x_goodguy >= 681 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and y_goodguy = 370 and x_goodguy > 320 and x_goodguy <= 689 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and y_goodguy = 271 and x_goodguy > 119 and x_goodguy <= 320 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and y_goodguy = 430 and x_goodguy > 119 and x_goodguy <= 320 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and y_goodguy = 430 and x_goodguy >= 681 and x_goodguy <= 881 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_LEFT_ARROW) and y_goodguy = 532 and x_goodguy > 119 and x_goodguy <= 881 then
	x_goodguy := x_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy
	    bullet_x := x_goodguy - 1
	    direction := 3
	elsif user_input (chr (32)) and ammo = 0 then
	end if
    end if

    % checks if bullet is within shooting parameters so bullet can keep moving
    if direction = 3 and bullet_x < maxx and shooting = true then
	bullet_x := bullet_x - 6
    end if

    % checks if bullet is out of game parameters to stop bullet
    if bullet_x < 0 then
	shooting := false
    end if

end goodguy_left

% goodguy movements down
proc goodguy_down
    if chars (KEY_DOWN_ARROW) and x_goodguy = 500 and y_goodguy > 70 then
	y_goodguy := y_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy - 1
	    bullet_x := x_goodguy
	    direction := 4
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_DOWN_ARROW) and x_goodguy = 320 and y_goodguy > 70 then
	y_goodguy := y_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy - 1
	    bullet_x := x_goodguy
	    direction := 4
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_DOWN_ARROW) and x_goodguy = 119 and y_goodguy > 172 then
	y_goodguy := y_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy - 1
	    bullet_x := x_goodguy
	    direction := 4
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_DOWN_ARROW) and x_goodguy = 881 and y_goodguy > 172 then
	y_goodguy := y_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy - 1
	    bullet_x := x_goodguy
	    direction := 4
	elsif user_input (chr (32)) and ammo = 0 then
	end if

    elsif chars (KEY_DOWN_ARROW) and x_goodguy = 680 and y_goodguy > 70 then
	y_goodguy := y_goodguy - 2
	% checks if ammo remaining to be able to shoot
	if user_input (chr (32)) and shooting = false and ammo > 0 then
	    shooting := true
	    ammo -= 1
	    bullet_y := y_goodguy - 1
	    bullet_x := x_goodguy
	    direction := 4
	elsif user_input (chr (32)) and ammo = 0 then
	end if
    end if

    % checks if bullet is within game parameters to keep going forward
    if direction = 4 and bullet_y < maxx and shooting = true then
	bullet_y := bullet_y - 6
    end if

    % checks if bullet is out of game parameters to stop bullet
    if bullet_y <= 0 then
	shooting := false
    end if
end goodguy_down

% bad guy movements
procedure badguy (x : int)

    % initializes the colour of the badguys
    badguy_colour (x) := brightred

    % initializes the colour of the badguys' eyecolour
    badguy_eyecolour (x) := white

    % decides where to move from the top left
    if x_badguy (x) = 119 and y_badguy (x) = 532 then
	chance_badguy (x) := Rand.Int (1, 2)
    end if

    % movement down from the top left
    if chance_badguy (x) = 1 and x_badguy (x) = 119 and y_badguy (x) <= 532 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement to the right from the top left corner
    elsif chance_badguy (x) = 2 and x_badguy (x) >= 119 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
    end if

    % decides where to move from far left, 2nd row
    if x_badguy (x) = 119 and y_badguy (x) = 430 then
	chance_badguy (x) := Rand.Int (2, 3)
    end if

    % movement to the right from far left, 2nd row
    if chance_badguy (x) = 2 and x_badguy (x) >= 119 and y_badguy (x) = 430 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from far left, 2nd row
    elsif chance_badguy (x) = 3 and x_badguy (x) = 119 and y_badguy (x) <= 430 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
    end if

    % decides where to move from far left, bottom row
    if x_badguy (x) = 119 and y_badguy (x) = 172 then
	chance_badguy (x) := Rand.Int (1, 2)
    end if

    % movement to the right from far left, bottom row
    if chance_badguy (x) = 1 and x_badguy (x) >= 119 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement upwards from far left, bottom row
    elsif chance_badguy (x) = 2 and x_badguy (x) = 119 and y_badguy (x) >= 172 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move from top of 2nd column
    if x_badguy (x) = 320 and y_badguy (x) = 532 then
	chance_badguy (x) := Rand.Int (5, 7)
    end if

    % movement downwards from top of 2nd column
    if chance_badguy (x) = 5 and x_badguy (x) = 320 and y_badguy (x) <= 532 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement to the right from top of 2nd column
    elsif chance_badguy (x) = 6 and x_badguy (x) >= 320 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement to the left from top of 2nd column
    elsif chance_badguy (x) = 7 and x_badguy (x) <= 320 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from 2nd column, 2nd row
    if x_badguy (x) = 320 and y_badguy (x) = 430 then
	chance_badguy (x) := Rand.Int (1, 3)
    end if

    % movement upwards from 2nd column, 2nd row
    if chance_badguy (x) = 1 and x_badguy (x) = 320 and y_badguy (x) >= 430 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement downwards from 2nd column, 2nd row
    elsif chance_badguy (x) = 2 and x_badguy (x) = 320 and y_badguy (x) <= 430 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement to the left from 2nd column, 2nd row
    elsif chance_badguy (x) = 3 and x_badguy (x) <= 320 and y_badguy (x) = 430 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from 2nd column, 2nd last row
    if x_badguy (x) = 320 and y_badguy (x) = 172 then
	chance_badguy (x) := Rand.Int (30, 33)
    end if

    % movement downwards from 2nd column, 2nd last row
    if chance_badguy (x) = 30 and x_badguy (x) = 320 and y_badguy (x) <= 172 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement upwards from 2nd column, 2nd last row
    elsif chance_badguy (x) = 31 and x_badguy (x) = 320 and y_badguy (x) >= 172 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement left from 2nd column, 2nd last row
    elsif chance_badguy (x) = 32 and x_badguy (x) <= 320 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement right from 2nd column, 2nd last row
    elsif chance_badguy (x) = 33 and x_badguy (x) >= 320 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) + 1
	direction := 2
    end if

    % decides where to move from bottom left row
    if x_badguy (x) = 320 and y_badguy (x) = 70 then
	chance_badguy (x) := Rand.Int (90, 91)
    end if

    % movement upwards from bottom left row
    if chance_badguy (x) = 91 and x_badguy (x) = 320 and y_badguy (x) >= 70 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % movement right from bottom left row
    if chance_badguy (x) = 90 and x_badguy (x) >= 320 and y_badguy (x) = 70 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
    end if

    % decides where to move from bottom centre row
    if x_badguy (x) = 500 and y_badguy (x) = 70 then
	chance_badguy (x) := Rand.Int (22, 24)
    end if

    % movement upwards from bottom centre row
    if chance_badguy (x) = 22 and x_badguy (x) = 500 and y_badguy (x) >= 70 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement left from bottom centre row
    elsif chance_badguy (x) = 23 and x_badguy (x) <= 500 and y_badguy (x) = 70 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement right from bottom centre row
    elsif chance_badguy (x) = 24 and x_badguy (x) >= 500 and y_badguy (x) = 70 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
    end if

    % decides where to move from centre, 2nd last row
    if x_badguy (x) = 500 and y_badguy (x) = 172 then
	chance_badguy (x) := Rand.Int (40, 43)
    end if

    % movement right from centre, 2nd last row
    if chance_badguy (x) = 40 and x_badguy (x) >= 500 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement left from centre, 2nd last row
    elsif chance_badguy (x) = 41 and x_badguy (x) <= 500 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement up from centre, 2nd last row
    elsif chance_badguy (x) = 42 and x_badguy (x) = 500 and y_badguy (x) <= 172 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement down from centre, 2nd last row
    elsif chance_badguy (x) = 43 and x_badguy (x) = 500 and y_badguy (x) >= 172 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move from 1st column, 2nd last row
    if x_badguy (x) = 119 and y_badguy (x) = 271 then
	chance_badguy (x) := Rand.Int (50, 52)
    end if

    % movement right from 1st column, 2nd last row
    if chance_badguy (x) = 50 and x_badguy (x) >= 119 and y_badguy (x) = 271 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from 1st column, 2nd last row
    elsif chance_badguy (x) = 51 and x_badguy (x) = 119 and y_badguy (x) <= 271 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement up from 1st column, 2nd last row
    elsif chance_badguy (x) = 52 and x_badguy (x) = 119 and y_badguy (x) >= 271 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move from 2nd column, 2nd last row
    if x_badguy (x) = 320 and y_badguy (x) = 271 then
	chance_badguy (x) := Rand.Int (60, 62)
    end if

    % movement left from 2nd column, 2nd last row
    if chance_badguy (x) = 60 and x_badguy (x) <= 320 and y_badguy (x) = 271 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement down from 2nd column, 2nd last row
    elsif chance_badguy (x) = 61 and x_badguy (x) = 320 and y_badguy (x) <= 271 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement up from 2nd column, 2nd last row
    elsif chance_badguy (x) = 62 and x_badguy (x) = 320 and y_badguy (x) >= 271 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move from bottom right row
    if x_badguy (x) = 680 and y_badguy (x) = 70 then
	chance_badguy (x) := Rand.Int (70, 71)
    end if

    % movement left from bottom right row
    if chance_badguy (x) = 70 and x_badguy (x) <= 680 and y_badguy (x) = 70 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement up from bottom right row
    elsif chance_badguy (x) = 71 and x_badguy (x) = 680 and y_badguy (x) >= 70 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move from 2nd column, 2nd row
    if x_badguy (x) = 320 and y_badguy (x) = 370 then
	chance_badguy (x) := Rand.Int (80, 82)
    end if

    % movement right from 2nd column, 2nd row
    if chance_badguy (x) = 80 and x_badguy (x) >= 320 and y_badguy (x) = 370 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from 2nd column, 2nd row
    elsif chance_badguy (x) = 81 and x_badguy (x) = 320 and y_badguy (x) <= 370 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement up from 2nd column, 2nd row
    elsif chance_badguy (x) = 82 and x_badguy (x) = 320 and y_badguy (x) >= 370 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move from 3rd column, middle row
    if x_badguy (x) = 500 and y_badguy (x) = 370 then
	chance_badguy (x) := Rand.Int (90, 93)
    end if

    % movement right from 3rd column, middle row
    if chance_badguy (x) = 90 and x_badguy (x) >= 500 and y_badguy (x) = 370 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from 3rd column, middle row
    elsif chance_badguy (x) = 91 and x_badguy (x) = 500 and y_badguy (x) <= 370 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement up from 3rd column, middle row
    elsif chance_badguy (x) = 92 and x_badguy (x) = 500 and y_badguy (x) >= 370 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement left from 3rd column, middle row
    elsif chance_badguy (x) = 93 and x_badguy (x) <= 500 and y_badguy (x) = 370 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from 4th column, 2nd last row
    if x_badguy (x) = 680 and y_badguy (x) = 172 then
	chance_badguy (x) := Rand.Int (100, 103)
    end if

    % movement right from 4th column, 2nd last row
    if chance_badguy (x) = 100 and x_badguy (x) >= 680 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from 4th column, 2nd last row
    elsif chance_badguy (x) = 101 and x_badguy (x) = 680 and y_badguy (x) <= 172 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement up from 4th column, 2nd last row
    elsif chance_badguy (x) = 102 and x_badguy (x) = 680 and y_badguy (x) >= 172 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement left from 4th column, 2nd last row
    elsif chance_badguy (x) = 103 and x_badguy (x) <= 680 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from top 3rd column
    if x_badguy (x) = 500 and y_badguy (x) = 532 then
	chance_badguy (x) := Rand.Int (110, 112)
    end if

    % movement right from top 3rd column
    if chance_badguy (x) = 110 and x_badguy (x) >= 500 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from top 3rd column
    elsif chance_badguy (x) = 111 and x_badguy (x) = 500 and y_badguy (x) <= 532 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement left from top 3rd column
    elsif chance_badguy (x) = 112 and x_badguy (x) <= 500 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from top 4th column
    if x_badguy (x) = 680 and y_badguy (x) = 532 then
	chance_badguy (x) := Rand.Int (120, 122)
    end if

    % movement right from top 4th column
    if chance_badguy (x) = 120 and x_badguy (x) >= 680 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement down from top 4th column
    elsif chance_badguy (x) = 121 and x_badguy (x) = 680 and y_badguy (x) <= 532 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement left from top 4th column
    elsif chance_badguy (x) = 122 and x_badguy (x) <= 680 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from 4th column and middle row
    if x_badguy (x) = 680 and y_badguy (x) = 370 then
	chance_badguy (x) := Rand.Int (130, 132)
    end if

    % movement right from 4th column and middle row
    if chance_badguy (x) = 130 and x_badguy (x) = 680 and y_badguy (x) >= 370 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement down from 4th column and middle row
    elsif chance_badguy (x) = 131 and x_badguy (x) = 680 and y_badguy (x) <= 370 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
	% movement left from 4th column and middle row
    elsif chance_badguy (x) = 132 and x_badguy (x) <= 680 and y_badguy (x) = 370 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
    end if

    % decides where to move from top 5th column
    if x_badguy (x) = 881 and y_badguy (x) = 532 then
	chance_badguy (x) := Rand.Int (140, 141)
    end if

    % movement left from top 5th column
    if chance_badguy (x) = 140 and x_badguy (x) <= 881 and y_badguy (x) = 532 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement down from top 5th column
    elsif chance_badguy (x) = 141 and x_badguy (x) = 881 and y_badguy (x) <= 532 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
    end if

    % decides where to move from far right corner
    if x_badguy (x) = 881 and y_badguy (x) = 172 then
	chance_badguy (x) := Rand.Int (150, 151)
    end if

    % movement left from far right corner
    if chance_badguy (x) = 150 and x_badguy (x) <= 881 and y_badguy (x) = 172 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement up from far right corner
    elsif chance_badguy (x) = 151 and x_badguy (x) = 881 and y_badguy (x) >= 172 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
    end if

    % decides where to move 4th column, 2nd row
    if x_badguy (x) = 680 and y_badguy (x) = 430 then
	chance_badguy (x) := Rand.Int (160, 162)
    end if

    % movement right from 4th column, 2nd row
    if chance_badguy (x) = 160 and x_badguy (x) >= 680 and y_badguy (x) = 430 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement up from 4th column, 2nd row
    elsif chance_badguy (x) = 161 and x_badguy (x) = 680 and y_badguy (x) >= 430 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement down from 4th column, 2nd row
    elsif chance_badguy (x) = 162 and x_badguy (x) = 680 and y_badguy (x) <= 430 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
    end if

    % decides where to move 4th column, 3rd row
    if x_badguy (x) = 680 and y_badguy (x) = 271 then
	chance_badguy (x) := Rand.Int (190, 192)
    end if

    % movement right from 4th column, 3rd row
    if chance_badguy (x) = 190 and x_badguy (x) >= 680 and y_badguy (x) = 271 then
	x_badguy (x) := x_badguy (x) + 1
	direction_badguy := 2
	% movement up from 4th column, 3rd row
    elsif chance_badguy (x) = 191 and x_badguy (x) = 680 and y_badguy (x) >= 271 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement down from 4th column, 3rd row
    elsif chance_badguy (x) = 192 and x_badguy (x) = 680 and y_badguy (x) <= 271 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
    end if

    % decides where to move 5th column, 2nd row
    if x_badguy (x) = 881 and y_badguy (x) = 430 then
	chance_badguy (x) := Rand.Int (170, 172)
    end if

    % movement left from 5th column, 2nd row
    if chance_badguy (x) = 170 and x_badguy (x) <= 881 and y_badguy (x) = 430 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement up from 5th column, 2nd row
    elsif chance_badguy (x) = 171 and x_badguy (x) = 881 and y_badguy (x) >= 430 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement down from 5th column, 2nd row
    elsif chance_badguy (x) = 172 and x_badguy (x) = 881 and y_badguy (x) <= 430 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
    end if

    % decides where to move 5th column, 3rd row
    if x_badguy (x) = 881 and y_badguy (x) = 271 then
	chance_badguy (x) := Rand.Int (180, 182)
    end if

    % movement left from 5th column, 3rd row
    if chance_badguy (x) = 180 and x_badguy (x) <= 881 and y_badguy (x) = 271 then
	x_badguy (x) := x_badguy (x) - 1
	direction_badguy := 4
	% movement up from 5th column, 3rd row
    elsif chance_badguy (x) = 181 and x_badguy (x) = 881 and y_badguy (x) >= 271 then
	y_badguy (x) := y_badguy (x) + 1
	direction_badguy := 3
	% movement down from 5th column, 3rd row
    elsif chance_badguy (x) = 182 and x_badguy (x) = 881 and y_badguy (x) <= 271 then
	y_badguy (x) := y_badguy (x) - 1
	direction_badguy := 1
    end if
end badguy

% bad guy and goodguy interaction when shooting
proc badguy_respawning (x : int)

    % initializes badguy boolean and locations
    if badguy_alive (x) = false then
	x_badguy (x) := 119
	y_badguy (x) := 532
	badguy_alive (x) := true
    end if

    % checks if badguy boolean is true to perform badguy procedure
    if badguy_alive (x) = true then
	badguy (x)
    end if

    % turns badguy black in the corner so it appears dead
    if x_badguy (x) = 0 and y_badguy (x) = 0 then
	badguy_colour (x) := black
	badguy_eyecolour (x) := black
    end if

    % brings back enemy that has been shot after a short amount of time
    if Time.Elapsed mod 1000 = 0 and x_badguy (x) = 0 and y_badguy (x) = 0 then
	badguy_alive (x) := false
    end if
end badguy_respawning

% procedure that senses when badguy touches goodguy
proc badguy_goodguy (x : int)

    % lose one life when badguy touches goodguy and resets locations
    if Math.Distance (x_goodguy, y_goodguy, x_badguy (x), y_badguy (x)) < 30 then
	delay (1000)
	lives -= 1
	x_goodguy := 500
	y_goodguy := 70
	x_badguy (x) := 119
	y_badguy (x) := 532
    end if
end badguy_goodguy

% procedure that makes ammo coordinates
proc proc_ammo (x, time1 : int)

    % checks time to see if its time to draw ammo
    if Time.Elapsed mod (time1) = 0 and ammo_alive (x) = false then
	ammo_alive (x) := true
    end if

    % checks to see if its time to generate a random location for ammo to appear
    if ammo_alive (x) = true and Time.Elapsed mod (time1) = 0 then
	item_chance := Rand.Int (1, 8)
	% generates random location for ammo to appear and ensures location is within game parameters
	if item_chance = 1 then
	    ammo_y (x) := 271
	    ammo_x (x) := Rand.Int (119, 320)
	elsif item_chance = 2 then
	    ammo_y (x) := 271
	    ammo_x (x) := Rand.Int (680, 881)
	elsif item_chance = 3 then
	    ammo_y (x) := 172
	    ammo_x (x) := Rand.Int (119, 881)
	elsif item_chance = 4 then
	    ammo_y (x) := 430
	    ammo_x (x) := Rand.Int (119, 320)
	elsif item_chance = 5 then
	    ammo_y (x) := 430
	    ammo_x (x) := Rand.Int (680, 881)
	elsif item_chance = 6 then
	    ammo_y (x) := 532
	    ammo_x (x) := Rand.Int (119, 881)
	elsif item_chance = 7 then
	    ammo_y (x) := 370
	    ammo_x (x) := Rand.Int (320, 680)
	elsif item_chance = 8 then
	    ammo_y (x) := 70
	    ammo_x (x) := Rand.Int (320, 680)
	end if
    end if

    % actually draws ammo item after location has been generated
    if ammo_alive (x) = true then
	Draw.Oval (ammo_x (x), ammo_y (x), 15, 15, brightred)
	Draw.Oval (ammo_x (x), ammo_y (x), 16, 16, brightred)
	Draw.Oval (ammo_x (x), ammo_y (x), 17, 17, brightred)
	Draw.Oval (ammo_x (x), ammo_y (x), 7, 7, brightred)
	Draw.Oval (ammo_x (x), ammo_y (x), 8, 8, brightred)
	Draw.ThickLine (ammo_x (x), ammo_y (x) - 20, ammo_x (x), ammo_y (x) + 20, 2, brightred)
	Draw.ThickLine (ammo_x (x) - 20, ammo_y (x), ammo_x (x) + 20, ammo_y (x), 2, brightred)
	% detects collision and user gains one ammo
	if Math.Distance (x_goodguy, y_goodguy, ammo_x (x), ammo_y (x)) < 30 then
	    ammo_alive (x) := false
	    ammo += 1
	end if
    end if
end proc_ammo

% procedure to draw dvd
proc dvd (x : int)
    % checks if dvd boolean is true and draws if it is true
    if dvd_present (x) = true then
	Draw.FillOval (DVD_X (x), DVD_Y (x), 20, 20, Rand.Int (0, maxcolor))
	Draw.Oval (DVD_X (x), DVD_Y (x), 18, 18, black)
	Draw.FillOval (DVD_X (x), DVD_Y (x), 7, 7, black)
	Draw.Oval (DVD_X (x), DVD_Y (x), 5, 5, grey)
	Draw.Oval (DVD_X (x), DVD_Y (x), 4, 4, grey)
	% checks if user collides with dvd and deletes dvd from gameset and adds 1 to the # of dvds needed to pass the level
	if Math.Distance (DVD_X (x), DVD_Y (x), x_goodguy, y_goodguy) < 30 then
	    dvd_present (x) := false
	    dvds_needed += 1
	end if
    end if
end dvd

% procedure for making copyright item
proc proc_copyright (x, time1 : int)
    % checks if its time to draw copyright content
    if Time.Elapsed mod (time1) = 0 and copyright (x) = false then
	copyright (x) := true
    end if

    % checks if its time to generate location for copyright content
    if copyright (x) = true and Time.Elapsed mod (time1) = 0 then
	item_chance := Rand.Int (1, 8)
	% generates random location for copyright content
	if item_chance = 1 then
	    copyright_y (x) := 271
	    copyright_x (x) := Rand.Int (119, 320)
	elsif item_chance = 2 then
	    copyright_y (x) := 271
	    copyright_x (x) := Rand.Int (680, 881)
	elsif item_chance = 3 then
	    copyright_y (x) := 172
	    copyright_x (x) := Rand.Int (119, 881)
	elsif item_chance = 4 then
	    copyright_y (x) := 430
	    copyright_x (x) := Rand.Int (119, 320)
	elsif item_chance = 5 then
	    copyright_y (x) := 430
	    copyright_x (x) := Rand.Int (680, 881)
	elsif item_chance = 6 then
	    copyright_y (x) := 532
	    copyright_x (x) := Rand.Int (119, 881)
	elsif item_chance = 7 then
	    copyright_y (x) := 370
	    copyright_x (x) := Rand.Int (320, 680)
	elsif item_chance = 8 then
	    copyright_y (x) := 70
	    copyright_x (x) := Rand.Int (320, 680)
	end if
    end if

    % draws copyright when random location is generated
    if copyright (x) = true then
	Draw.FillOval (copyright_x (x), copyright_y (x), 15, 15, yellow)
	Font.Draw ("C", copyright_x (x) - 7, copyright_y (x) - 8, font, black)
	% detects user and copyright content collision and increases user's score by 15
	if Math.Distance (x_goodguy, y_goodguy, copyright_x (x), copyright_y (x)) < 30 then
	    copyright (x) := false
	    score += 15
	end if
    end if
end proc_copyright

% procedure that draws badguy
proc draw_badguy (x : int)
    % checks direction badguy is facing to position eyes
    if direction_badguy = 1 then
	Draw.FillOval (x_badguy (x), y_badguy (x), 20, 20, badguy_colour (x))
	Draw.FillOval (x_badguy (x) + 5, y_badguy (x) + 2, 3, 5, badguy_eyecolour (x))
	Draw.FillOval (x_badguy (x) - 5, y_badguy (x) + 2, 3, 5, badguy_eyecolour (x))
    elsif direction_badguy = 2 then
	Draw.FillOval (x_badguy (x), y_badguy (x), 20, 20, badguy_colour (x))
	Draw.FillOval (x_badguy (x), y_badguy (x) + 2, 3, 5, badguy_eyecolour (x))
	Draw.FillOval (x_badguy (x) + 10, y_badguy (x) + 2, 3, 5, badguy_eyecolour (x))
    elsif direction_badguy = 3 then
	Draw.FillOval (x_badguy (x), y_badguy (x), 20, 20, badguy_colour (x))
    elsif direction_badguy = 4 then
	Draw.FillOval (x_badguy (x), y_badguy (x), 20, 20, badguy_colour (x))
	Draw.FillOval (x_badguy (x), y_badguy (x) + 2, 3, 5, badguy_eyecolour (x))
	Draw.FillOval (x_badguy (x) - 10, y_badguy (x) + 2, 3, 5, badguy_eyecolour (x))
    end if
end draw_badguy

% procedure that draws score, ammo, and lives count
proc score_ammo_lives
    Font.Draw ("Score: " + intstr (score), 70, 543, font, white)
    Font.Draw ("Ammo: " + intstr (ammo), 400, 543, font, white)
    Font.Draw ("Lives: " + intstr (lives), 700, 543, font, white)
end score_ammo_lives

% white out for columns
proc black_column (x, x1, x2, x3, x4 : int)
    Draw.FillBox (x, 487, x + 40, 511, black)
    Draw.FillBox (x1, 50, x1 + 40, 511, black)
    Draw.FillBox (x2, 50, x2 + 40, 511, black)
    Draw.FillBox (x3, 50, x3 + 40, 511, black)
    Draw.FillBox (x4, 487, x4 + 40, 511, black)
end black_column

% makes procedure to draw gameset when called
procedure gameset
    % draws background
    Draw.FillBox (0, 0, maxx, maxy, black)

    % top platform
    Draw.FillBox (100, 501, 900, 511, 68)
    Draw.FillBox (100, 487, 900, 497, white)

    % top platform upper brick marks
    for i : 120 .. 890 by 30
	Draw.ThickLine (i, 501, i, 511, 3, black)
    end for

    % top platform lower brick marks
    for i : 105 .. 905 by 30
	Draw.ThickLine (i, 487, i, 497, 3, black)
    end for

    % bottom platform
    Draw.FillBox (300, 41, 700, 51, 68)
    Draw.FillBox (300, 27, 700, 37, white)

    % bottom platform upper brick marks
    for i : 305 .. 700 by 30
	Draw.ThickLine (i, 41, i, 51, 3, black)
    end for

    % bottom platform lower brick marks
    for i : 320 .. 690 by 30
	Draw.ThickLine (i, 27, i, 37, 3, black)
    end for

    % long bottom platform
    Draw.FillBox (100, 141, 900, 151, 68)
    Draw.FillBox (100, 127, 900, 137, white)

    % long bottom platform upper brick marks
    for i : 120 .. 890 by 30
	Draw.ThickLine (i, 141, i, 151, 3, black)
    end for

    % long bottom platform lower brick marks
    for i : 105 .. 905 by 30
	Draw.ThickLine (i, 127, i, 137, 3, black)
    end for

    % left 2nd platform
    Draw.FillBox (140, 401, 300, 411, 68)
    Draw.FillBox (140, 387, 300, 397, white)

    % left 2nd platform upper brick marks
    for i : 160 .. 290 by 30
	Draw.ThickLine (i, 401, i, 411, 3, black)
    end for

    % left 2nd platform lower brick marks
    for i : 145 .. 305 by 30
	Draw.ThickLine (i, 387, i, 397, 3, black)
    end for

    %right 2nd platform
    Draw.FillBox (700, 401, 860, 411, 68)
    Draw.FillBox (700, 387, 860, 397, white)

    % right 2nd platform upper brick marks
    for i : 720 .. 840 by 30
	Draw.ThickLine (i, 401, i, 411, 3, black)
    end for

    % right 2nd platform lower brick marks
    for i : 705 .. 855 by 30
	Draw.ThickLine (i, 387, i, 397, 3, black)
    end for

    % left 3rd platform
    Draw.FillBox (130, 241, 300, 251, 68)
    Draw.FillBox (130, 227, 300, 237, white)

    % left 3rd platform upper brick marks
    for i : 160 .. 290 by 30
	Draw.ThickLine (i, 241, i, 251, 3, black)
    end for

    % left 3rd platform lower brick marks
    for i : 145 .. 305 by 30
	Draw.ThickLine (i, 227, i, 237, 3, black)
    end for

    % right 3rd platform
    Draw.FillBox (700, 241, 860, 251, 68)
    Draw.FillBox (700, 227, 860, 237, white)

    % right 3rd platform upper brick marks
    for i : 720 .. 850 by 30
	Draw.ThickLine (i, 241, i, 251, 3, black)
    end for

    %right 3rd platform lower brick marks
    for i : 705 .. 865 by 30
	Draw.ThickLine (i, 227, i, 237, 3, black)
    end for

    %middle 2nd platform
    Draw.FillBox (340, 341, 660, 351, 68)
    Draw.FillBox (340, 327, 660, 337, white)

    %middle 2nd platform upper brick marks
    for i : 364 .. 634 by 30
	Draw.ThickLine (i, 341, i, 351, 3, black)
    end for

    % middle 2nd platform lower brick marks
    for i : 349 .. 649 by 30
	Draw.ThickLine (i, 327, i, 337, 3, black)
    end for

    % hides part of ladders
    Draw.FillBox (480, 300, 520, 400, black)
    black_column (100, 300, 480, 660, 861)

    %1st column
    Draw.FillBox (99, 150, 109, 510, 67)
    Draw.FillBox (129, 150, 139, 510, 67)

    %lst column ladder steps
    for i : 150 .. 510 by 10
	Draw.ThickLine (99, i, 139, i, 3, 67)
    end for

    %2nd column
    Draw.FillBox (300, 50, 310, 510, 67)
    Draw.FillBox (330, 50, 340, 510, 67)

    %2nd column ladder steps
    for i : 50 .. 510 by 10
	Draw.ThickLine (300, i, 340, i, 3, 67)
    end for

    %3rd column
    Draw.FillBox (480, 50, 490, 510, 67)
    Draw.FillBox (510, 50, 520, 510, 67)

    %3rd columm ladder steps
    for i : 50 .. 510 by 10
	Draw.ThickLine (480, i, 520, i, 3, 67)
    end for

    %4th column
    Draw.FillBox (660, 50, 670, 510, 67)
    Draw.FillBox (690, 50, 700, 510, 67)

    %4th column ladder steps
    for i : 50 .. 510 by 10
	Draw.ThickLine (660, i, 700, i, 3, 67)
    end for

    %5th column
    Draw.FillBox (861, 150, 871, 510, 67)
    Draw.FillBox (891, 150, 901, 510, 67)

    %5th column ladder steps
    for i : 150 .. 510 by 10
	Draw.ThickLine (861, i, 901, i, 3, 67)
    end for
end gameset

% draws level transitions
proc level (x : int)
    % sets Turing to setting where it can draw on screen
    View.Set ("nooffscreenonly")

    % draws background
    Draw.FillBox (0, 0, maxx, maxy, black)

    % draws the level the player is advancing to
    Font.Draw ("LEVEL " + intstr (x), 70, 543, font, white)
    delay (1000)

    % sets turing to setting where it can draw off screen to reduce flickering of game
    View.Set ("offscreenonly")

    % initializes badguy and item values/booleans so next level can run with 1 more badguy and needed dvd
    for i : 1 .. x
	x_badguy (i) := 119
	y_badguy (i) := 532
	badguy_alive (i) := false
	dvd_present (i) := true
    end for

    % initializes user's position for next level
    x_goodguy := 500
    y_goodguy := 70

    % initialize the number of dvds needed
    dvds_needed := 0
end level

% game over screen
proc gameover
    Draw.FillBox (0, 0, maxx, maxy, black)
    Font.Draw ("GAME OVER", 300, 300, font4, white)
    Font.Draw ("Score: " + intstr (score), 330, 200, font1, white)
end gameover

% the stages
proc stage (level : int)
    % this loop runs the actual playing part of the game (stage)
    loop

	% this calls the keyboard commands for the user/goodguy
	goodguy_up

	% detects if bullet has hit any of the enemies in the array
	for i : 1 .. level
	    erase_enemy (i)
	end for

	% this calls the keyboard commands for the user/goodguy
	goodguy_right

	% detects if bullet has hit any of the enemies in the array
	for i : 1 .. level
	    erase_enemy (i)
	end for

	% this calls the keyboard commands for the user/goodguy
	goodguy_left

	% detects if bullet has hit any of the enemies in the array
	for i : 1 .. level
	    erase_enemy (i)
	end for

	% this calls the keyboard commands for the user/goodguy
	goodguy_down

	% detects if bullet has hit any of the enemies in the array
	for i : 1 .. level
	    erase_enemy (i)
	end for

	% calls procedure to respawn enemy
	for i : 1 .. level
	    badguy_respawning (i)
	end for

	% checks if good guy and badguy touch
	for i : 1 .. level
	    badguy_goodguy (i)
	end for

	% exits if user runs out of lives
	if lives = 0 then
	    exit
	end if

	% calls procedure to draw start game setting
	gameset

	% bullet
	if shooting = true then
	    Draw.FillOval (bullet_x, bullet_y, 6, 6, yellow)
	end if

	% draws good guy
	Draw.FillOval (x_goodguy, y_goodguy, 20, 20, 54)
	Draw.FillOval (x_goodguy + 5, y_goodguy + 2, 3, 5, white)
	Draw.FillOval (x_goodguy - 5, y_goodguy + 2, 3, 5, white)

	if chars (KEY_UP_ARROW) then
	    Draw.FillOval (x_goodguy, y_goodguy, 20, 20, 54)
	elsif chars (KEY_RIGHT_ARROW) then
	    Draw.FillOval (x_goodguy, y_goodguy, 20, 20, 54)
	    Draw.FillOval (x_goodguy, y_goodguy + 2, 3, 5, white)
	    Draw.FillOval (x_goodguy + 10, y_goodguy + 2, 3, 5, white)
	elsif chars (KEY_LEFT_ARROW) then
	    Draw.FillOval (x_goodguy, y_goodguy, 20, 20, 54)
	    Draw.FillOval (x_goodguy, y_goodguy + 2, 3, 5, white)
	    Draw.FillOval (x_goodguy - 10, y_goodguy + 2, 3, 5, white)
	elsif chars (KEY_DOWN_ARROW) then
	    Draw.FillOval (x_goodguy, y_goodguy, 20, 20, 54)
	    Draw.FillOval (x_goodguy + 5, y_goodguy + 2, 3, 5, white)
	    Draw.FillOval (x_goodguy - 5, y_goodguy + 2, 3, 5, white)
	end if

	% draws badguys depending on level #
	for i : 1 .. level
	    draw_badguy (i)
	end for

	% draw score, ammo, lives count
	score_ammo_lives

	% dvd present or not
	for i : 1 .. level
	    dvd (i)
	end for

	% checks if user collects the # of dvds needed to pass the level
	if dvds_needed = level then
	    exit
	end if

	% draws ammo
	proc_ammo (1, 400)
	proc_ammo (2, 1500)

	% draws copyrighted material
	proc_copyright (1, 800)
	proc_copyright (2, 1200)

	View.Update
	delay (3)
	cls
    end loop
end stage

% makes procedure for the story of the game
proc story
    % first slide of story
    Draw.FillBox (0, 0, maxx, maxy, black)
    % draws copy-not
    Draw.FillOval (450, 210, 50, 50, 54)
    Draw.FillOval (435, 212, 5, 13, white)
    Draw.FillOval (420, 212, 5, 13, white)
    Font.Draw ("This is Copy-Not.", 150, 300, font4, white)

    delay (1500)

    % second slide of story
    Draw.FillBox (0, 0, maxx, maxy, black)
    % draws copy-not
    Draw.FillOval (450, 210, 50, 50, 54)
    Draw.FillOval (435, 212, 5, 13, white)
    Draw.FillOval (420, 212, 5, 13, white)
    Font.Draw ("He lives in the world ", 80, 400, font4, white)
    Font.Draw ("of anti-piracy.", 180, 300, font4, white)

    delay (2000)

    % third slide of story
    Draw.FillBox (0, 0, maxx, maxy, black)
    Font.Draw ("It was a peaceful place", 35, 450, font4, white)
    Font.Draw ("where piracy was only", 85, 300, font4, white)
    Font.Draw ("just a story.", 205, 150, font4, white)

    delay (3000)

    % fourth slide of story
    Draw.FillBox (0, 0, maxx, maxy, black)
    Font.Draw ("Until one day...", 80, 300, font4, white)

    delay (1500)

    % fifth slide of story
    Draw.FillBox (0, 0, maxx, maxy, black)
    Font.Draw ("The Copy-Bots invaded.", 80, 300, font4, white)
    % draws copy bot
    Draw.FillOval (450, 210, 50, 50, brightred)
    Draw.FillOval (435, 212, 5, 13, white)
    Draw.FillOval (420, 212, 5, 13, white)

    delay (1500)

    % sixth slide of story
    Draw.FillBox (0, 0, maxx, maxy, black)
    Font.Draw ("And so...", 80, 450, font4, white)
    Font.Draw ("The Piracy Wars begin...", 70, 300, font4, white)
    % draws copy bot
    Draw.FillOval (550, 210, 50, 50, brightred)
    Draw.FillOval (535, 212, 5, 13, white)
    Draw.FillOval (520, 212, 5, 13, white)
    % draws copy-not
    Draw.FillOval (350, 210, 50, 50, 54)
    Draw.FillOval (335, 212, 5, 13, white)
    Draw.FillOval (320, 212, 5, 13, white)

    delay (2000)
end story

% makes procedure to draw the slide which occurs when user wins game
proc celebrate
    % sets Turing to setting where things are drawn on the screen
    View.Set ("nooffscreenonly")
    % runs winning scene
    loop
	Draw.FillBox (0, 0, maxx, maxy, black)
	Font.Draw ("YOU WIN!", 330, 290, font4, Rand.Int (0, maxcolor))

	% randomly generates and draws x coordinates and y coordinates of small randomly coloured ovals
	for i : 1 .. 800
	    celebrate_x (i) := Rand.Int (1, maxx)
	    celebrate_y (i) := Rand.Int (1, maxy)
	    Draw.FillOval (celebrate_x (i), celebrate_y (i), 1, 1, Rand.Int (0, maxcolor))
	end for

	delay (100)
    end loop
end celebrate

% sets Turing to draw things off the screen to reduce flickering
View.Set ("offscreenonly")

% draws menu
Draw.FillBox (0, 0, maxx, maxy, black)
Font.Draw ("PIRACY WARS", 100, 450, font4, white)
Pic.Draw (pirated_logo, 140, 100, picMerge)
Font.Draw ("Play", 600, 300, font1, white)
Font.Draw ("Instructions", 480, 210, font1, white)
Font.Draw ("Story", 580, 120, font1, white)

% draws badguy
Draw.FillOval (800, 500, 50, 50, brightred)
Draw.FillOval (785, 502, 5, 13, white)
Draw.FillOval (770, 502, 5, 13, white)

% draws goodguy
Draw.FillOval (650, 500, 50, 50, 54)
Draw.FillOval (635, 502, 5, 13, white)
Draw.FillOval (620, 502, 5, 13, white)

% sets turing to setting where things are drawn on screen
View.Set ("nooffscreenonly")

% checks mouse to see if user has clicked any option
loop
    % calls mouse command
    Mouse.Where (mouse_x, mouse_y, button)

    % checks and changes colour if user's cursor hovers over the play button
    if button = 0 and mouse_x >= 600 and mouse_x <= 748 and mouse_y >= 300 and mouse_y <= 350 then
	Font.Draw ("Play", 600, 300, font1, brightred)
    else
	Font.Draw ("Play", 600, 300, font1, white)
    end if

    % checks and changes colour if user's cursor hovers over the instructions button
    if button = 0 and mouse_x >= 480 and mouse_x <= 855 and mouse_y >= 210 and mouse_y <= 260 then
	Font.Draw ("Instructions", 480, 210, font1, brightred)
    else
	Font.Draw ("Instructions", 480, 210, font1, white)
    end if

    % checks and changes colour if user's cursor hovers over the story button
    if button = 0 and mouse_x >= 580 and mouse_x <= 750 and mouse_y >= 120 and mouse_y <= 170 then
	Font.Draw ("Story", 580, 120, font1, brightred)
    else
	Font.Draw ("Story", 580, 120, font1, white)
    end if

    % checks and goes to specified menu choice if user's cursor clicks any of the buttons/options
    if button = 1 and mouse_x >= 480 and mouse_x <= 855 and mouse_y >= 210 and mouse_y <= 260 then
	menu := 3
	exit
    elsif button = 1 and mouse_x >= 600 and mouse_x <= 748 and mouse_y >= 300 and mouse_y <= 350 then
	menu := 2
	exit
    elsif button = 1 and mouse_x >= 580 and mouse_x <= 750 and mouse_y >= 120 and mouse_y <= 170 then
	menu := 4
	exit
    end if
end loop

% sets turing to draw things off screen to reduce flickering
View.Set ("offscreenonly")

% runs instructions manual
loop

    % calls mouse command
    Mouse.Where (mouse_x, mouse_y, button)

    % gives options for the menu
    case menu of
	    % main manu selection
	label 1 :
	    % sets turing to draw things off screen to reduce flickering
	    View.Set ("offscreenonly")

	    % initializes live count so that user always starts with 5 lives before starting a game
	    lives := 3

	    % draws main menu
	    Draw.FillBox (0, 0, maxx, maxy, black)
	    Font.Draw ("PIRACY WARS", 100, 450, font4, white)
	    Pic.Draw (pirated_logo, 140, 100, picMerge)
	    Font.Draw ("Play", 600, 300, font1, white)
	    Font.Draw ("Instructions", 480, 210, font1, white)
	    Font.Draw ("Story", 580, 120, font1, white)

	    % draws badguy
	    Draw.FillOval (800, 500, 50, 50, brightred)
	    Draw.FillOval (785, 502, 5, 13, white)
	    Draw.FillOval (770, 502, 5, 13, white)

	    % draws goodguy
	    Draw.FillOval (650, 500, 50, 50, 54)
	    Draw.FillOval (635, 502, 5, 13, white)
	    Draw.FillOval (620, 502, 5, 13, white)

	    % sets turing to setting where things are drawn on screen
	    View.Set ("nooffscreenonly")

	    % checks mouse to see if user has clicked any option
	    loop
		% calls mouse command
		Mouse.Where (mouse_x, mouse_y, button)

		% checks and changes colour if user's cursor hovers over the play button
		if button = 0 and mouse_x >= 600 and mouse_x <= 748 and mouse_y >= 300 and mouse_y <= 350 then
		    Font.Draw ("Play", 600, 300, font1, brightred)
		else
		    Font.Draw ("Play", 600, 300, font1, white)
		end if

		% checks and changes colour if user's cursor hovers over the instructions button
		if button = 0 and mouse_x >= 480 and mouse_x <= 855 and mouse_y >= 210 and mouse_y <= 260 then
		    Font.Draw ("Instructions", 480, 210, font1, brightred)
		else
		    Font.Draw ("Instructions", 480, 210, font1, white)
		end if

		% checks and changes colour if user's cursor hovers over the story button
		if button = 0 and mouse_x >= 580 and mouse_x <= 750 and mouse_y >= 120 and mouse_y <= 170 then
		    Font.Draw ("Story", 580, 120, font1, brightred)
		else
		    Font.Draw ("Story", 580, 120, font1, white)
		end if

		% checks and goes to specified menu choice if user's cursor clicks any of the buttons/options
		if button = 1 and mouse_x >= 480 and mouse_x <= 855 and mouse_y >= 210 and mouse_y <= 260 then
		    menu := 3
		    exit
		elsif button = 1 and mouse_x >= 600 and mouse_x <= 748 and mouse_y >= 300 and mouse_y <= 350 then
		    menu := 2
		    exit
		elsif button = 1 and mouse_x >= 580 and mouse_x <= 750 and mouse_y >= 120 and mouse_y <= 170 then
		    menu := 4
		    exit
		end if
	    end loop

	    % play option
	label 2 :

	    % sets turing to draw things off screen to reduce flickering
	    View.Set ("offscreenonly")

	    % stage 1
	    stage (1)

	    % runs all stages after stage 1
	    for i : 2 .. 14
		% exits for loop if user runs out of lives
		if lives = 0 then
		    exit
		end if
		% draws level transition and initializes values for stage 2
		level (i)
		% stage 2
		stage (i)
	    end for

	    View.Update

	    % sets turing to draw things on screen
	    View.Set ("nooffscreenonly")
	    % checks if lives have run out or not and either draws gameover screen or winning screen
	    if lives = 0 then
		gameover
		exit
	    else
		celebrate
		exit
	    end if

	    % instructions option
	label 3 :

	    % sets turing to draw things off screen to reduce flickering
	    View.Set ("nooffscreenonly")

	    % draws how to play
	    Draw.FillBox (0, 0, maxx, maxy, black)
	    Font.Draw ("HOW TO PLAY", 270, 500, font4, white)

	    % good guy
	    Draw.FillOval (200, 530, 30, 30, 54)
	    Draw.FillOval (195, 532, 3, 8, white)
	    Draw.FillOval (183, 532, 3, 8, white)

	    % bad guy
	    Draw.FillOval (770, 530, 30, 30, brightred)
	    Draw.FillOval (775, 532, 3, 8, white)
	    Draw.FillOval (787, 532, 3, 8, white)

	    % drawing the 3 boxes
	    for i : 1 .. 599 by 299
		boxes (i)
	    end for

	    % draws bottom box
	    Draw.FillBox (56, 30, 620, 185, 54)
	    Draw.FillBox (550, 30, 620, 185, white)

	    % labelling the first box
	    Font.Draw ("Shoot criminals", 80, 420, font3, white)
	    Font.Draw ("with the spacebar", 65, 385, font3, white)

	    % labelling the second box
	    Font.Draw ("Move with the", 390, 420, font3, white)
	    Font.Draw ("arrow keys", 410, 385, font3, white)

	    % labelling the third box
	    Font.Draw ("Collect all the", 678, 420, font3, white)
	    Font.Draw ("DVDs to advance", 680, 385, font3, white)

	    % labelling the bottom box
	    Font.Draw ("• Collect more copyright", 70, 140, font3, white)
	    Font.Draw ("content for extra points!", 100, 105, font3, white)
	    Font.Draw ("• Collect ammo!", 70, 60, font3, white)

	    % copyrighted material
	    Draw.FillOval (585, 127, 15, 15, yellow)
	    Font.Draw ("C", 578, 119, font3, black)

	    % ammo
	    Draw.Oval (585, 70, 15, 15, brightred)
	    Draw.Oval (585, 70, 16, 16, brightred)
	    Draw.Oval (585, 70, 17, 17, brightred)
	    Draw.Oval (585, 70, 7, 7, brightred)
	    Draw.Oval (585, 70, 8, 8, brightred)
	    Draw.ThickLine (585, 70 - 20, 585, 70 + 20, 2, brightred)
	    Draw.ThickLine (585 - 20, 70, 585 + 20, 70, 2, brightred)

	    % drawing the space bar
	    Draw.Box (130, 260, 260, 310, black)
	    Draw.Box (129, 259, 261, 311, black)
	    Draw.Box (128, 258, 262, 312, black)
	    Font.Draw ("SPACE", 165, 280, font2, black)

	    % left arrow key
	    arrowkeys (0, 0)
	    arrowkeys (-1, 1)
	    arrows_left_right (0)
	    Draw.ThickLine (433, 265, 438, 270, 2, black)
	    Draw.ThickLine (433, 265, 438, 260, 2, black)

	    % down arrow key
	    arrowkeys (50, 0)
	    arrowkeys (49, 1)
	    arrows_up_down (0)
	    Draw.ThickLine (493, 250, 488, 255, 2, black)
	    Draw.ThickLine (493, 250, 498, 255, 2, black)

	    % right arrow key
	    arrowkeys (100, 0)
	    arrowkeys (99, 1)
	    arrows_left_right (100)
	    Draw.ThickLine (555, 265, 550, 270, 2, black)
	    Draw.ThickLine (555, 265, 550, 260, 2, black)

	    % up arrow key
	    arrowkeys (50, 50)
	    arrowkeys (49, 51)
	    arrows_up_down (50)
	    Draw.ThickLine (493, 325, 488, 320, 2, black)
	    Draw.ThickLine (493, 325, 498, 320, 2, black)

	    % dvd
	    Draw.FillOval (795, 290, 50, 50, Rand.Int (0, maxcolor))
	    Draw.Oval (795, 290, 48, 48, black)
	    Draw.FillOval (795, 290, 12, 12, black)
	    Draw.Oval (795, 290, 10, 10, grey)
	    Draw.Oval (795, 290, 9, 9, grey)

	    % checks if user clicks the play button
	    loop

		% calls mouse command
		Mouse.Where (mouse_x, mouse_y, button)

		% detects if user's cursor hovers over the play button
		if button = 0 and mouse_x >= 730 and mouse_x <= 850 and mouse_y >= 100 and mouse_y <= 130 then
		    Font.Draw ("Play", 730, 100, font1, brightred)
		else
		    Font.Draw ("Play", 730, 100, font1, white)
		end if

		% detects if user's clicks play button
		if button = 1 and mouse_x >= 730 and mouse_x <= 850 and mouse_y >= 100 and mouse_y <= 130 then
		    exit
		end if
	    end loop

	    % sets turing to draw things off screen to reduce flickering
	    View.Set ("offscreenonly")
	    % stage 1
	    stage (1)
	    % all stages after stage 1
	    for i : 2 .. 14
	    % checks if user has run out of lives
		if lives = 0 then
		    exit
		end if
		level (i)
		stage (i)
	    end for

	    % sets turing to draw things on screen
	    View.Set ("nooffscreenonly")
	    % checks if user has run out of lives or not and either draws gameover screen or winning screen
	    if lives = 0 then
		gameover
		exit
	    else
		celebrate
		exit
	    end if

	    % story option
	label 4 :
	% sets turing to draw things on screen
	    View.Set ("nooffscreenonly")
	    % calls procedure to draw out story
	    story
	    % goes back to main menu
	    menu := 1
    end case
end loop
