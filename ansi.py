# ANSI escape codes for colors
RED_BG = "\u001b[41m"  # Red background
RESET = "\u001b[0m"

# Characters for drawing rounded corners and borders
TOP_LEFT_CORNER = "╭"
TOP_RIGHT_CORNER = "╮"
BOTTOM_LEFT_CORNER = "╰"
BOTTOM_RIGHT_CORNER = "╯"
HORIZONTAL_LINE = "─"
VERTICAL_LINE = "│"


def print_rounded_box_with_text(text):
    # Calculate the box size
    text_length = len(text)
    box_width = text_length + 2  # 2 for side borders

    # Top border
    print(TOP_LEFT_CORNER + HORIZONTAL_LINE * (box_width - 2) + TOP_RIGHT_CORNER)

    # Text line with red background
    print(VERTICAL_LINE + RED_BG + text + RESET + VERTICAL_LINE)

    # Bottom border
    print(BOTTOM_LEFT_CORNER + HORIZONTAL_LINE * (box_width - 2) + BOTTOM_RIGHT_CORNER)


# Example usage
print_rounded_box_with_text("PAW | 00:01:00 | main.dart | INFO ")
