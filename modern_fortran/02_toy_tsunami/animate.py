"""Command line utility which generates the animation of the waves

The contract:
    source data: data/tsunami_out.txt
    destination: data/tsunami.gif => requires ffmpeg installed
"""

from typing import Tuple, List
import typer
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.animation import FuncAnimation
import matplotlib

matplotlib.use('Agg')
matplotlib.rcParams.update({'font.size': 16})


def load_data(filename: str) -> Tuple[np.array, np.array, List]:
    """Transform the data into a numpy array ready for plotting
    
    Returns:
        * h: water height [m]
        * x: the space coordinates (1D grid) [m]
        * time: the time step [s]
    """
    with open(filename) as f:
        data = [line.rstrip().split() for line in f.readlines()] 

    time = [float(line[0]) for line in data]
    h = np.array([[float(x) for x in line[1:]] for line in data])
    x = np.arange(1, h.shape[1] + 1)

    return h, x, time


def init_figure():
    fig = plt.figure(figsize=(8, 3))
    ax = fig.add_axes((0.12, 0.2, 0.8, 0.7))
    plt.ylim(-0.2, 1.5)
    plt.xlim(1, 100)
    plt.xticks(range(25, 125, 25))
    plt.yticks(np.arange(-0.2, 1.4, 0.2))
    plt.grid()
    plt.xlabel('Distance [m]')
    plt.ylabel('Water elevation [m]')
    return fig, ax


def main(
    step: int = typer.Argument(90),
    snapshot: bool = typer.Option(True, "--snapshot/--animation", 
        help="Save snapshot, otherwise animation"),
    data_path: str = typer.Option("data/tsunami_out.txt", help="Path to simulation data"), 
    output_dir: str = typer.Option("data", help="Path to output writing"),
) -> None:
    """Usage examples: \n
    .gif: python animate.py --animation \n
    .svg: python animate.py 300 --data_path=data/tsunami_out.txt --output_dir=data
    """
    typer.echo("""
        ~~~~~~ Welcome to the tsunami visualizer ~~~~~~~
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    """)
    try:
        h, x, time = load_data(data_path)
    except FileNotFoundError as err:
        typer.echo("File not found")
        typer.Exit(2)
    
    if h.shape[0] == 0:
        typer.echo("No data could be parsed from the file")
        typer.Exit(2)

    fig, ax = init_figure()
    line, = ax.plot([], [], 'b-')
    
    def plot_time_step(time_step: int):
        line.set_data(x, h[time_step])
        plt.title(r'Water elevation [m], time step ' + str(time_step))
        return line,

    def init():
        line.set_data([], [])
        return line,

    if snapshot:
        if step >= h.shape[0]:
            typer.echo("The time step doesn't exist in simulated data")
            raise typer.Exit(2)

        out_dir = f"{output_dir}/water_height_{step :d}.svg"
        plt.plot(x, h[step], 'b-')
        ax.fill_between(x, -0.5, h[step], color='b', alpha=0.4)
        plt.title(r'Water elevation [m], time step ' + str(step))
        plt.savefig(out_dir)
        plt.close(fig)

        typer.echo(f"Output file: {out_dir}")
    else:
        animation = FuncAnimation(
            fig, plot_time_step, init_func=init, 
            frames=range(0, int(h.shape[0] / 2), 10), 
            interval=10, blit=True
        )
        animation.save(f"{output_dir}/tsunami.gif", writer="ffmpeg")
        plt.close(fig)


if __name__ == "__main__":
    typer.run(main)