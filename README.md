# Simple Car Game

A simple car game developed using the Processing library and the Minim library for audio. The game involves controlling a player character to avoid oncoming cars.

## Features
- Three different car types: old car, new car, and truck.
- Background music and sound effects.
- Score tracking.
- Collision detection.
- Multiple game modes: menu, game, and death screen.

## Installation

1. **Download and Install Processing**: Download Processing from [here](https://processing.org/download/) and install it.

2. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/simple-car-game.git
    ```

3. **Install Minim Library**:
    - Open Processing.
    - Go to `Sketch` > `Import Library` > `Add Library`.
    - Search for `Minim` and install it.

4. **Add Resources**:
    - Ensure the following resources are placed in the `data` folder inside the project directory:
      - `car1.png`, `car2.png`, `truck.png`
      - `background.png`, `menu.png`, `menu2.png`, `grave.png`, `death.png`, `character.png`
      - `menu.mp3`, `bell.mp3`, `bgm.mp3`
      - `Pixeboy-z8XGD.ttf`

## Usage

1. **Open the Project**:
    - Open Processing.
    - Load the `SimpleCarGame.pde` file from the cloned repository.

2. **Run the Game**:
    - Click the `Run` button in Processing.

3. **Controls**:
    - **Arrow Keys**: Move the player character (left, right, up, down).
    - **'R' Key**: Restart the game.
    - **'M' Key**: Return to the main menu.

## Code Structure

- **Car Class**: Manages car properties and behaviors.
- **Game States**: Handles different game modes (menu, game, death screen).
- **Collision Detection**: Checks for collisions between the player and cars.
- **Audio Management**: Loads and plays background music and sound effects.

## Contributing

Feel free to fork this repository, make your changes, and submit a pull request. Contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or suggestions, please reach out to [your email].

