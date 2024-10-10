<div align="center">
  <img
    src="assets/logo/main.svg"
    alt="SuperPong's Logo"
    title="SuperPong's Logo"
    width="200"
  />
</div>

<div align="center">
  <h1><strong>SuperPong</strong></h1>
</div>

Imagine classical pong, but with the addition of “super” abilities. That’s **SuperPong**! New paddle types with super abilities, and new ball effects and sorts. All made with the trusty Godot Engine. And by [me](https://github.com/IamFastre).

<div align="center">
  <h2><strong>Paddles</strong></h2>
</div>

### 1. **Classic Paddle**

<div align="center">
  <img width="75%" src="docs/media/paddle_classic.png" />
</div>

Just your ordinary regular paddle. It may not be good at one thing, but it's enough to do the job, I guess.

| **Stat** | **Value** |
|:-:|:-:|
| Icon | <img src="assets/sprites/ball.png" width="20" /> |
| Color | ![#ffffff](https://placehold.co/12x12/ffffff/ffffff.png) |
| Height | `200` |
| Speed | `100` |
| Sprint Speed | `150` |
| Ball Maneuver | `0.5` |

---

### 2. **Castle Paddle**

<div align="center">
  <img width="75%" src="docs/media/paddle_castle.png" />
</div>

Ever felt like a loser who can't defend a damn ball? Well, don't I have the solution for you! `Castle` is gonna be your new best friend.

#### • **Ability**
When pressing the ability button, it expands even more. Expanding slows you down though.

| **Stat** | **Value** | (*Extended*) |
|:-:|:-:|:-:|
| Icon | <img src="assets/paddle-icons/shield.png" width="20" /> | (bigger) |
| Color | ![#4458f2](https://placehold.co/12x12/4458f2/4458f2.png) | `-` |
| Height | `320` | `400` |
| Speed | `80` | `48` |
| Sprint Speed | `×` | `-` |
| Ball Maneuver | `0.66` | `-` |

---

### 3. **Speedy Paddle**

<div align="center">
  <img width="75%" src="docs/media/paddle_speedy.png" />
</div>

Ever feel like running away from your problems but you just *can't*? Yeah, me too. Until we find a way to do that, how about speedster paddle for you?

#### • **Ability**
When pressing the ability button, it runs quick to the y-level of the ball. You ought to have good timing and wait for it to recharge though.

| **Stat** | **Value** |
|:-:|:-:|
| Icon | <img src="assets/paddle-icons/lightning.png" width="20" /> |
| Color | ![#ffca0f](https://placehold.co/12x12/ffca0f/ffca0f.png) |
| Height | `140` |
| Speed | `150` |
| Sprint Speed | `225` |
| Ball Maneuver | `0.35` |

---

### 4. **Strike Paddle**

<div align="center">
  <img width="75%" src="docs/media/paddle_strike.png" />
</div>

`Strike` is when you're tired of playing the defense, play the offensive role for once now.

#### • **Ability**
When pressing the ability button, it reflects the ball if it's in your half. You'll have to wait for it to recharge to reuse it though.

| **Stat** | **Value** |
|:-:|:-:|
| Icon | <img src="assets/paddle-icons/sword.png" width="20" /> |
| Color | ![#ff3b3b](https://placehold.co/12x12/ff3b3b/ff3b3b.png) |
| Height | `200` |
| Speed | `100` |
| Sprint Speed | `150` |
| Ball Maneuver | `0.85` |

---

### 5. **Tempo Paddle**

<div align="center">
  <img width="75%" src="docs/media/paddle_tempo.png" />
</div>

Time control is amazing, you can touch bo- I mean you can uhhh, fuck. `Tempo` just means time in Italian, okay?

#### • **Ability**
When pressing the ability button, the ball gets slowed down by a factor of `0.5`, and pressing it again while the ability is active, disables it. You'll have to wait for it to recharge to reuse it though.

| **Stat** | **Value** | (*Slowing*) |
|:-:|:-:|:-:|
| Icon | <img src="assets/paddle-icons/clock.png" width="20" /> | (black clock hand) |
| Color | ![#006e62](https://placehold.co/12x12/006e62/006e62.png) | `-` |
| Height | `170` | `-` |
| Speed | `100` | `-` |
| Sprint Speed | `120` | `150` |
| Ball Maneuver | `0.66` | `1.25` |

---

<div align="center">
  <h2><strong>Controls</strong></h2>
</div>

Since there isn't much to do other than move and use ability, the controls are simple. \
*Note: Double pressing the Up/Down (or clicking one then the other immediately) will result in your paddle sprinting. This is useful for mobile players especially where there's not "sprint" button currently.*

### 1. **Keyboard & Mouse**

|   | P1 | P2 |
|:-:|:--:|:--:|
| Up | `W` | `↑` |
| Down | `S` | `↓` |
| Sprint | `L-⇧` | `R-⇧` |
| Ability | `⎵` | `R-⌘` |
| Pause | `ESC` | `P` |

### 2. **Controller**

*Soon, I promise.*

### 3. **Touch**

**Two arrows** for *vertical movement* (can be swiped over to trigger) (double tap and hold to sprint). \
**Middle button** for *ability* (can only be clicked to trigger). \
Also there's a *pause button* for pausing...


<div align="center">
  <img width="75%" src="docs/media/touch_controls.png" />
</div>

---

<div align="center">
  Made with
  <br/>
  <a href="https://godotengine.org/">
    <img height="50" src="https://godotengine.org/assets/press/logo_small_monochrome_dark.png" />
  </a>
</div>

$${and\space\color{red}Love}$$
