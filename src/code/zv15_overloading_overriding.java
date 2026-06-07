class Logger {
    public void log(String message) {
        System.out.println("text: " + message);
    }

    public void log(int value) {
        System.out.println("number: " + value);
    }

    public void log(Object value) {
        System.out.println("object: " + value);
    }
}

class PrefixedLogger extends Logger {
    @Override
    public void log(String message) {
        System.out.println("app: " + message);
    }
}

public class OverloadingOverridingDemo {
    public static void main(String[] args) {
        Logger logger = new PrefixedLogger();

        logger.log("started");
        logger.log(2026);
        logger.log(new Object());
    }
}
