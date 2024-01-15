include reactors 
include image

# ================================== Data Definitions 
# Posn data definition
data Posn:
  | posn(x :: Number, y :: Number)
end

# Playstate data definition
data Playstate:
  | start 
  | ready 
  | play 
  | shriram
  | over 
end

# World data definition
data World:
  | world(
      fox-posn :: Posn, 
      gnd-posn :: Posn, 
      fire-posn :: Posn,
      stone-posn :: Posn,
      score-count :: Number,
      high-score :: Number,
      game-state :: Boolean, 
      energy :: Number, 
      jump-velocity :: Number, 
      max-height :: Number, 
      time-count :: Number,
      screen :: Playstate,
      shriram-count :: Number)
end

# ================================== Scaling Constants 
FOX-SCALE = 0.06
FIRE-SCALE= 0.0125
STN-SCALE = 0.075
BG-SCALE = 0.235
SHRIRAM-SCALE = 0.1

# ================================== Sprite Library
# Frame images for Idle Fox animation

# Frame images for Running Fox animation
fox-run1 = scale(FOX-SCALE, image-url("https://tinyurl.com/yr37v9kv"))
fox-run2 = scale(FOX-SCALE, image-url("https://tinyurl.com/ykwtarn6"))
fox-run3 = scale(FOX-SCALE, image-url("https://tinyurl.com/pvmm8xff"))
fox-run4 = scale(FOX-SCALE, image-url("https://tinyurl.com/53vm7rdv"))
fox-run5 = scale(FOX-SCALE, image-url("https://tinyurl.com/4vfk3bfc"))
fox-run6 = scale(FOX-SCALE, image-url("https://tinyurl.com/mwkf5kk6"))

# Frame images for Campfire obstacle
fire1 = scale(FIRE-SCALE, image-url("https://tinyurl.com/bp8bt7av"))
fire2 = scale(FIRE-SCALE, image-url("https://tinyurl.com/4asxn8be"))
fire3 = scale(FIRE-SCALE, image-url("https://tinyurl.com/3d4bbu4r"))
fire4 = scale(FIRE-SCALE, image-url("https://tinyurl.com/2y66h3fp"))
fire5 = scale(FIRE-SCALE, image-url("https://tinyurl.com/2dm3hssh"))
fire-frame-list = [list: fire1, fire2, fire3, fire4, fire5]

# Frame images for Stone obstacle
stone-obs = scale(STN-SCALE, image-url("https://tinyurl.com/5yh9cvfh"))

# Background Frame Image
bg = scale(BG-SCALE, image-url("https://tinyurl.com/445xtnw3"))

# Frames for Shriram Dancing Emote
shriram1 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/mpmmtksw"))
shriram2 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/mr3kfx33"))
shriram3 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/3t6e9x2a"))
shriram4 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/mwwcp5mw"))
shriram5 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/p8wubtcr"))
shriram6 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/ybcm5b93"))
shriram7 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/ys9cw7tm"))
shriram8 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/5y6rm2e6"))
shriram9 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/zn889zyt"))
shriram10 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/29mkr5jx"))
shriram11 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/38cp9mdt"))
shriram12 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/yc422nzj"))
shriram13 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/2kj87mbu"))
shriram14 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/28vhahw3"))
shriram15 = scale(SHRIRAM-SCALE, image-url("https://tinyurl.com/ynf4pjsn"))

# Ground Sprite
ground = rectangle(500, 25, "solid", "brown")

# ================================== Game Constants 
# Game Window Dimensions
WIDTH = 500
HEIGHT = 350

# Sprite Dimensions
GND-HEIGHT = 25
FOX-HEIGHT = 20
FOX-WIDTH = 20
INITIAL-MAX-HEIGHT = HEIGHT - GND-HEIGHT - (FOX-HEIGHT / 2)

# Position Constants
TITLE-POSN = posn(WIDTH / 2, HEIGHT / 4)
SCORE-POSN = posn(45, 20)
FOX-INITIAL-Y = HEIGHT - GND-HEIGHT - FOX-HEIGHT

# Obstacle Speed Constants
FIRE-SPEED = 1
STONE-SPEED = 2

# Displacement Constants
FIRE-DISPLACEMENT = 22
JUMP-DISPLACEMENT= 15
STONE-DISPLACEMENT = 22

# Tick Count Constants
TICK-COUNT = 0.0625

# Caption Strings
TITLE = text-font("Silly Fox", 50, "black", "Arial", 
    "decorative", "normal", "bold", false)
INTRO-TEXT = "Press 'ENTER' to start, 'r' to restart, and 'q' to quit. Good luck!"
INTRO-DISPLAY = text-font(INTRO-TEXT, 17, "black", "Treasure Map Deadhand",
    "decorative", "italic", "normal", false)
OUTRO-TEXT = "Game Over! Hit 'r' to restart, and 'q' to quit."
READY-TEXT = "Ready? Hit 'Up/Space' to play"
SHRIRAM-TEXT = "You crossed 19! You made Shriram happy!"

# Collision Threshold 
# NOTE: Bigger the COLLISION-THRESHOLD, easier the game <3
COLLISION-THRESH = 4

# ================================== Animations
# Function for Fox Sprite Animation
fun fox-run(image-num):
  doc: "cycles through a list of fox images"
  fox-run-frame-list = 
    [list: fox-run1, fox-run2, fox-run3, fox-run4, fox-run5, fox-run6]
  fox-run-frame-list.get(image-num)
where:
  fox-run(0) is fox-run1
  fox-run(5) is fox-run6
end

# Function for Shriram Dancing Animation
fun shriram-emote(image-num):
  doc: "cycles through a list of shriram emote images"
  shriram-list = [list: shriram1, shriram2, shriram3, shriram4, shriram5, 
    shriram6, shriram7, shriram8, shriram9,
    shriram10, shriram11, shriram12, shriram13, shriram14]
  shriram-list.get(image-num)
where:
  shriram-emote(4) is shriram5
  shriram-emote(0) is shriram1
  shriram-emote(12) is shriram13
end

# Function for Campfire Animations
fun fire():
  doc: "returns random image from list of fire images"
  index = num-random(5)
  fire-frame-list.get(index)
where:
  fun one-of(fyre, fyre-lst):
    member(fyre-lst, fyre)
  end
  fire() is%(one-of) fire-frame-list
end

# Dear TAs, please, respectfully, laugh at the following code. 
# Function for Background display
fun bg-scene():
  doc: "returns bg"
  bg
where:
  bg-scene() is bg
end

# Function for Stone display
fun stone(): 
  doc: "returns stone"
  stone-obs 
where:
  stone() is stone-obs
end
# Stop laughing.

# ================================== World states
# Initial Start World State 
# this is the position the game starts with
init-pos = 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT / 2)),
    posn(WIDTH - 50, FOX-INITIAL-Y + 5),
    posn(WIDTH - 175, FOX-INITIAL-Y + 5),
    0,
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    0,
    start,
    0)

# Play World State
# this is where the game play occurs
play-pos = 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(WIDTH + 100, FOX-INITIAL-Y + 5),
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0,
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    0,
    play,
    0)

# Ready World State
ready-pos = 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(WIDTH + 100, FOX-INITIAL-Y + 5),
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0,
    0,
    true,
    0,
    0,
    HEIGHT - GND-HEIGHT - (FOX-HEIGHT / 2),
    0,
    ready,
    0)

# Refreshed World State
r-press-pos = 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT / 2)),
    posn(WIDTH + 100, FOX-INITIAL-Y + 5),
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0,
    0,
    true,
    0,
    0,
    HEIGHT - GND-HEIGHT - (FOX-HEIGHT / 2),
    0,
    start,
    0)

# ================================== Update Helper Functions
# Function to wrap around the fire obstacle
fun fire-wrap-x(fire-p :: Posn) -> Number:
  doc: "given a position, returns the modulus of the x coord."
  divisor = WIDTH + 200
  num-modulo(fire-p.x - FIRE-DISPLACEMENT - FIRE-SPEED, divisor)
where:
  fire-wrap-x(posn(0, 0)) is 677
  fire-wrap-x(posn(-100, PI)) is 577
  fire-wrap-x(posn(1000, 1000)) is 277
end

# Placement function for Spawning Obstacles
fun spawn(wor) -> World:
  doc: "places the obstacles onto the background"
  world(
    wor.fox-posn, 
    wor.gnd-posn, 
    # set position for campfire obstacle
    posn(fire-wrap-x(wor.fire-posn), wor.fire-posn.y), 
    # set position for stone obstacle
    posn(fire-wrap-x(wor.stone-posn), wor.stone-posn.y),
    wor.score-count, 
    wor.high-score,
    wor.game-state, 
    wor.energy, 
    wor.jump-velocity, 
    wor.max-height,
    # add 1 to time-count to keep track of the clock
    wor.time-count + 1,
    wor.screen,
    wor.shriram-count)
where:
  spawn(init-pos) is
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT / 2)),
    posn(427, FOX-INITIAL-Y + 5),
    posn(302, FOX-INITIAL-Y + 5),
    0,
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    1,
    start,
    0)
  spawn(ready-pos) is 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    0,
    0,
    true,
    0,
    0,
    HEIGHT - GND-HEIGHT - (FOX-HEIGHT / 2),
    1,
    ready,
    0)
  spawn(play-pos) is 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    0, 
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    1,
    play,
    0)
end

# Function for Fox sprite movement
fun fox-move(wor :: World, dir :: String) -> World:
  doc: "moves the fox based on a keypress"
  sign = 
    if dir == "up": 
      {(x, y): x - y} 
    else: 
      {(x, y): x + y} 
    end
  new-max-height = 
    if dir == "down": 
      wor.max-height + JUMP-DISPLACEMENT 
    else: 
      wor.max-height 
    end
  new-jump-disp = 
    if dir == "dont move": 
      0 
    else: 
      JUMP-DISPLACEMENT 
    end
  world(
    posn(wor.fox-posn.x, sign(wor.fox-posn.y, new-jump-disp)), 
    wor.gnd-posn, 
    posn(fire-wrap-x(wor.fire-posn), wor.fire-posn.y),
    posn(fire-wrap-x(wor.stone-posn), wor.stone-posn.y), 
    wor.score-count + TICK-COUNT, 
    wor.high-score,
    wor.game-state, 
    wor.energy, 
    wor.jump-velocity, 
    new-max-height,
    wor.time-count + 1,
    wor.screen,
    wor.shriram-count + 1)
where:
  fox-move(play-pos, "up") is 
  world(
    posn(70, FOX-INITIAL-Y - 15),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    TICK-COUNT,
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    1,
    play,
    1)
  fox-move(play-pos, "down") is 
  world(
    posn(70, FOX-INITIAL-Y + 15),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    TICK-COUNT,
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT + 15,
    1,
    play,
    1)
  fox-move(play-pos, "dont move") is 
  world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    TICK-COUNT,
    0,
    true,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    1,
    play,
    1)
end

# ------------------------ Update Function
fun update(wor :: World) -> World:
  doc: "updates the world state every tick"
  cases (Playstate) wor.screen:
      #if in start state, make no changes
    | start => wor
      #if in ready, no change
    | ready => wor
      #over, updates high-score
    | over => 
      highscore = 
        # if score-count is more than highscore, set new highscore
        if wor.score-count > wor.high-score:
          wor.score-count
        else:
          wor.high-score
        end
      world(
        wor.fox-posn,
        wor.gnd-posn,
        wor.fire-posn,
        wor.stone-posn,
        wor.score-count,
        # highscore changed to new highscore
        highscore,
        wor.game-state,
        wor.energy,
        wor.jump-velocity,
        wor.max-height,
        wor.time-count,
        over,
        wor.shriram-count)
      #if in play state, adjust world based on keypress/collision
    | play =>
      if collision(wor):
        world(
          wor.fox-posn,
          wor.gnd-posn,
          wor.fire-posn,
          wor.stone-posn,
          wor.score-count,
          wor.high-score,
          wor.game-state,
          wor.energy,
          wor.jump-velocity,
          wor.max-height,
          wor.time-count,
          # if sprite collides with obstacle, playstate changed from 'play' to 'over'
          over,
          wor.shriram-count)
      else if (num-modulo(wor.time-count, 304) == 0) # if the score is a multiple of 19
        and not(wor.score-count == 0): # and score is not 0
        # SHRIRAM DANCES!!
        world(
          wor.fox-posn,
          wor.gnd-posn,
          wor.fire-posn,
          wor.stone-posn,
          wor.score-count,
          wor.high-score,
          wor.game-state,
          wor.energy,
          wor.jump-velocity,
          wor.max-height,
          wor.time-count,
          shriram,
          0)
      else if wor.max-height == 315:
        # no key action
        fox-move(wor, "dont move")
      else if wor.fox-posn.y <= wor.max-height:
        # fox going down
        fox-move(wor, "down")
      else if wor.max-height == 240:
        # fox going up
        fox-move(wor, "up")
      end
    | shriram =>
      # if shriram dances for over 5 seconds
      if wor.shriram-count >= 80:
        world(
          wor.fox-posn,
          wor.gnd-posn,
          wor.fire-posn,
          wor.stone-posn,
          wor.score-count,
          wor.high-score,
          wor.game-state,
          wor.energy,
          wor.jump-velocity,
          wor.max-height,
          wor.time-count,
          # play state changes from 'shriram' to 'play'
          play,
          0)
      else if collision(wor):
        world(
          wor.fox-posn,
          wor.gnd-posn,
          wor.fire-posn,
          wor.stone-posn,
          wor.score-count,
          wor.high-score,
          wor.game-state,
          wor.energy,
          wor.jump-velocity,
          wor.max-height,
          wor.time-count,
          # check for collision; if collides, change playstate from 'shriram' to 'over'
          over,
          wor.shriram-count)
      else if wor.max-height == 315:
        fox-move(wor, "dont move")
      else if wor.fox-posn.y <= wor.max-height:
        fox-move(wor, "down")
      else if wor.max-height == 240:
        fox-move(wor, "up")
      end
  end
where:
  #no change if screen is not in play pos
  update(init-pos) is init-pos
  update(ready-pos) is ready-pos
  update(
    world(
      posn(0, 0),
      posn(0, 0),
      posn(0, 0),
      posn(0, 0),
      0,
      0,
      false,
      0,
      0,
      0,
      0,
      over,
      0))
    is 
  world(
    posn(0, 0),
    posn(0, 0),
    posn(0, 0),
    posn(0, 0),
    0,
    0,
    false,
    0,
    0,
    0,
    0,
    over,
    0)
  #if screen is play and there is a collision, change screen to over
  update(
    world(
      posn(10, 10),
      posn(0, 0),
      posn(5, 5),
      posn(0, 0),
      0,
      0,
      false,
      0,
      0,
      0,
      0,
      play,
      0))
    is 
  world(
    posn(10, 10),
    posn(0, 0),
    posn(5, 5),
    posn(0, 0),
    0,
    0,
    false,
    0,
    0,
    0,
    0,
    over,
    0)
  #if no jump has occured, update world where the fox's posn doesnt change
  update(
    world(
      posn(0, 0),
      posn(0, 0),
      posn(50, 50),
      posn(50, 50),
      0,
      0,
      false,
      0,
      0,
      INITIAL-MAX-HEIGHT,
      0,
      play,
      0))
    is 
  world(
    posn(0, 0),
    posn(0, 0),
    posn(27, 50),
    posn(27, 50),
    TICK-COUNT,
    0,
    false,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    1,
    play,
    1)
  #if jump occured, update world with fox's position changed
  update(
    world(
      posn(70, FOX-INITIAL-Y),
      posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
      posn(WIDTH + 100, FOX-INITIAL-Y + 5),
      posn(WIDTH + 400, FOX-INITIAL-Y + 5),
      0,
      0,
      true,
      0,
      0,
      240,
      0,
      play,
      0))
    is 
  world(
    posn(70, 290),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    TICK-COUNT,
    0,
    true,
    0,
    0,
    240,
    1,
    play,
    1)
  #if fox is descending after jump, update world with fox's position changed
  update(
    world(
      posn(70, 255),
      posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
      posn(WIDTH + 100, FOX-INITIAL-Y + 5),
      posn(WIDTH + 400, FOX-INITIAL-Y + 5),
      0,
      0,
      true,
      0,
      0,
      255,
      0,
      play,
      0))
    is 
  world(
    posn(70, 270),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
    posn(577, FOX-INITIAL-Y + 5),
    posn(177, FOX-INITIAL-Y + 5),
    TICK-COUNT,
    0,
    true,
    0,
    0,
    270,
    1,
    play,
    1)
end

# ================================== Key Pressed Functions
fun key-pressed(wor :: World, key :: String) -> World:
  doc: "updates the world based on a keypress"
  #if 'enter' or 'r' is pressed, playstate changes to 'ready'
  if (key == "enter") or (key == "r"):
    world(
      posn(70, FOX-INITIAL-Y),
      posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))),
      posn(WIDTH + 100, FOX-INITIAL-Y + 5),
      posn(WIDTH + 400, FOX-INITIAL-Y + 5),
      0,
      wor.high-score,
      true,
      0,
      0,
      HEIGHT - GND-HEIGHT - (FOX-HEIGHT / 2),
      0,
      ready,
      0)
    #if q pressed, gamestate changed to false
  else if key == "q":
    world(
      wor.fox-posn,
      wor.gnd-posn,
      wor.fire-posn,
      wor.stone-posn,
      wor.score-count,
      wor.high-score,
      false,
      wor.energy,
      wor.jump-velocity,
      wor.max-height,
      wor.time-count,
      wor.screen,
      wor.shriram-count)
    #if ' ' or 'up' pressed, fox jumps and playstate changes 'play' or 'ready' to 'play'
  else if ((key == " ") or (key == "up")) and (wor.fox-posn.y == FOX-INITIAL-Y) 
    and ((wor.screen == play) or (wor.screen == ready)):
    world(
      wor.fox-posn, 
      wor.gnd-posn, 
      wor.fire-posn, 
      wor.stone-posn,
      wor.score-count, 
      wor.high-score,
      wor.game-state, 
      wor.energy, 
      wor.jump-velocity, 
      wor.max-height - 75,
      wor.time-count,
      play,
      wor.shriram-count)
    #if ' ' or 'up' pressed, fox jumps or playstate changes 'shriram' or 'ready' to 'shriram'
  else if ((key == " ") or (key == "up")) and (wor.fox-posn.y == FOX-INITIAL-Y) 
    and ((wor.screen == shriram) or (wor.screen == ready)):
    world(
      wor.fox-posn, 
      wor.gnd-posn, 
      wor.fire-posn, 
      wor.stone-posn,
      wor.score-count, 
      wor.high-score,
      wor.game-state, 
      wor.energy, 
      wor.jump-velocity, 
      wor.max-height - 75,
      wor.time-count,
      shriram,
      wor.shriram-count)
  else: 
    wor
  end
where:
  #enter changes world into ready-pos
  key-pressed(play-pos, "enter") is ready-pos
  #r changes world into ready-pos
  key-pressed(play-pos, "r") is ready-pos
  #q changes game-state to false
  key-pressed(init-pos, "q") 
    is world(
    posn(70, FOX-INITIAL-Y),
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT / 2)),
    posn(WIDTH - 50, FOX-INITIAL-Y + 5),
    posn(WIDTH - 175, FOX-INITIAL-Y + 5),
    0,
    0,
    false,
    0,
    0,
    INITIAL-MAX-HEIGHT,
    0,
    start,
    0)
  #" "/up do not work unless in ready state or play state
  key-pressed(init-pos, " ") is init-pos
  key-pressed(init-pos, "up") is init-pos
  #" "/up works in play state
  key-pressed(play-pos, "up") 
    is world(
    posn(70, FOX-INITIAL-Y), 
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))), 
    posn(WIDTH + 100, FOX-INITIAL-Y + 5), 
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0, 
    0,
    true, 
    0, 
    0, 
    INITIAL-MAX-HEIGHT - 75,
    0,
    play,
    0)
  key-pressed(play-pos, " ") 
    is world(
    posn(70, FOX-INITIAL-Y), 
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))), 
    posn(WIDTH + 100, FOX-INITIAL-Y + 5), 
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0, 
    0,
    true, 
    0, 
    0, 
    INITIAL-MAX-HEIGHT - 75,
    0,
    play,
    0)
  #" "/up do not work if fox is already in the air
  key-pressed(
    world(
      posn(70, FOX-INITIAL-Y + 75), 
      posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))), 
      posn(WIDTH + 100, FOX-INITIAL-Y + 5), 
      posn(WIDTH + 400, FOX-INITIAL-Y + 5),
      0, 
      0,
      true, 
      0, 
      0, 
      INITIAL-MAX-HEIGHT - 75,
      0,
      play,
      0), "up") is 
  world(
    posn(70, FOX-INITIAL-Y + 75), 
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))), 
    posn(WIDTH + 100, FOX-INITIAL-Y + 5), 
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0,
    0,
    true, 
    0, 
    0, 
    INITIAL-MAX-HEIGHT - 75,
    0,
    play,
    0)
  key-pressed(
    world(
      posn(70, FOX-INITIAL-Y + 75), 
      posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))), 
      posn(WIDTH + 100, FOX-INITIAL-Y + 5), 
      posn(WIDTH + 400, FOX-INITIAL-Y + 5),
      0,
      0,
      true, 
      0, 
      0, 
      INITIAL-MAX-HEIGHT - 75,
      0,
      play,
      0), " ") is 
  world(
    posn(70, FOX-INITIAL-Y + 75), 
    posn(WIDTH / 2, HEIGHT - (GND-HEIGHT - (GND-HEIGHT / 2))), 
    posn(WIDTH + 100, FOX-INITIAL-Y + 5), 
    posn(WIDTH + 400, FOX-INITIAL-Y + 5),
    0, 
    0,
    true, 
    0, 
    0, 
    INITIAL-MAX-HEIGHT - 75,
    0,
    play,
    0)
  #if any other key is pressed, do nothing
  key-pressed(init-pos, "x") is init-pos
  key-pressed(play-pos, "down") is play-pos
end

# ================================== Other functions
fun collision(wor) -> Boolean:
  doc: "checks if fox collided w/ an obstacle"
  # Stone collision dimensions
  stone-left = wor.stone-posn.x - (image-width(stone()) / COLLISION-THRESH)
  stone-top = wor.stone-posn.y - (image-height(stone()) / COLLISION-THRESH)
  
  # Campfire collision dimensions
  fire-left = wor.fire-posn.x - (image-width(fire()) / COLLISION-THRESH)
  fire-top = wor.fire-posn.y - (image-height(fire()) / COLLISION-THRESH)
  
  # Fox collision dimensions
  fox-right = wor.fox-posn.x + (image-width(fox-run(0)) / 5)
  fox-bottom = wor.fox-posn.y + FOX-HEIGHT
  
  # checks if fox collides with obstacles 
  ((fire-left <= fox-right) and (fire-top <= fox-bottom)) or 
  ((stone-left <= fox-right) and (stone-top <= fox-bottom))
where:
  collision(init-pos) is false
  collision(ready-pos) is false
  collision(play-pos) is false
  collision(
    world(
      posn(100, 100),
      posn(0, 0),
      posn(50, 50),
      posn(0, 0),
      0,
      0,
      false,
      0,
      0,
      0,
      0,
      start,
      0)) 
    is true
  collision(
    world(
      posn(100, 100),
      posn(0, 0),
      posn(0, 0),
      posn(50, 50),
      0,
      0,
      false,
      0,
      0,
      0,
      0,
      start,
      0))
    is true
end

# Function for game-over
# returns false is game-state is false
fun game-over(wor) -> Boolean:
  doc: "womp womp :("
  not(wor.game-state)
where:
  game-over(init-pos) is false
  game-over(ready-pos) is false
  game-over(play-pos) is false
  game-over(
    world(
      posn(0, 0),
      posn(0, 0),
      posn(0, 0),
      posn(0, 0),
      0,
      0,
      false,
      0,
      0,
      0,
      0,
      start,
      0)) 
    is true
end

# ================================== Place Sprite on Game Window
fun place-sprites(wor :: World) -> Image:
  doc: "produces an image based on game scene"
  # Score Text to display on Game Window
  score-text = 
    text("Score: " + num-to-string(num-round(wor.score-count)), 20, "black")
  # High-score text to display on Game Window
  high-score-text = 
    text("Highscore: " + num-to-string(num-round(wor.high-score)), 20, "black")
  
  # Base Game Image
  image = place-image(
    fire(), 
    wor.fire-posn.x, 
    wor.fire-posn.y, 
    place-image(stone(),
      wor.stone-posn.x,
      wor.stone-posn.y,
      place-image(
        fox-run(num-modulo(wor.time-count, 6)), 
        wor.fox-posn.x, 
        wor.fox-posn.y, 
        place-image(
          score-text, 
          SCORE-POSN.x, 
          SCORE-POSN.y,
          place-image(
            high-score-text,
            WIDTH - (2 * SCORE-POSN.x),
            SCORE-POSN.y,
            place-image(
              ground, 
              wor.gnd-posn.x, 
              wor.gnd-posn.y, 
              bg-scene()))))))
  
  # Check World Playstates to output corresponding image
  cases (Playstate) wor.screen:
    | start =>
      # Start Screen
      place-image(TITLE, TITLE-POSN.x, TITLE-POSN.y, 
        place-image(INTRO-DISPLAY, WIDTH / 2, HEIGHT / 2, image))
    | over=>
      # Game Over Screen
      place-image(text(OUTRO-TEXT, 14, "black"), WIDTH / 2, HEIGHT / 2, image)
    | ready =>
      # Ready Screen
      place-image(text(READY-TEXT, 14, "black"), WIDTH / 2, HEIGHT / 2, image)
    | shriram =>
      # SHRIRAM DANCING SCREEN!!
      place-image(shriram-emote(num-modulo(wor.time-count, 13)), 
        TITLE-POSN.x, TITLE-POSN.y,
        place-image(text(SHRIRAM-TEXT, 14, "black"), 
          WIDTH / 2, HEIGHT / 2, image))
    | play => 
      # Base image for game play
      image
  end
  # no tests for place-sprites because campfire obstacle has a random frame on each tick
end

# ================================== Reactor 
animation = reactor:
  # Reactor starts with initial position of init-pos
  init: init-pos,
  seconds-per-tick: TICK-COUNT,
  on-tick: update,
  to-draw: place-sprites,
  on-key: key-pressed,
  # if q is pressed, game-state changes to false
  # game-over flips boolean
  # reactor stops when game-over is true
  stop-when: game-over,
  # when game is stopped (when 'q' is pressed), game window is closed
  close-when-stop: true
end

# ================================== Interact with the reactor
interact(animation)
