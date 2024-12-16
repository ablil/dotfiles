import logging

# Define the custom log level
HIGHLIGHT_LEVEL = 25  # Between INFO (20) and WARNING (30)

# Add the new level name to the logging module
logging.addLevelName(HIGHLIGHT_LEVEL, "HIGHLIGHT")



class CustomLogger(logging.Logger):
    def highlight(self, message, *args, **kwargs):
        """
        Log a message with the custom HIGHLIGHT level.
        """
        if self.isEnabledFor(HIGHLIGHT_LEVEL):
            self._log(HIGHLIGHT_LEVEL, message, args, **kwargs)

class ColoredFormatter(logging.Formatter):
    """
    Custom formatter to add colors to log messages based on log levels.
    """
    COLORS = {
        logging.DEBUG: "\033[94m",  # Blue
        HIGHLIGHT_LEVEL: "\033[92m",   # Green
        logging.WARNING: "\033[93m", # Yellow
        logging.ERROR: "\033[91m",  # Red
        logging.CRITICAL: "\033[95m", # Magenta
    }
    RESET = "\033[0m"

    def format(self, record: logging.LogRecord) -> str:
        # Add color to the log level name and message
        color = self.COLORS.get(record.levelno, self.RESET)
        record.levelname = f"{color}{record.levelname}{self.RESET}"
        message = super().format(record)
        return f"{color}{message}{self.RESET}"

def create_logger(name: str) -> logging.Logger :
    logging.setLoggerClass(CustomLogger)
    logger = logging.getLogger(name)
    logger.setLevel(logging.INFO)

    handler = logging.StreamHandler()
    handler.setFormatter(ColoredFormatter('%(message)s'))

    if not logger.hasHandlers():
        logger.addHandler(handler)

    return logger
    
