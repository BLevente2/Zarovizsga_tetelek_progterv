public class BankAccount {
    private static final double MIN_BALANCE = 0.0;

    private final String owner;
    private double balance;

    public BankAccount(String owner, double openingBalance) {
        if (owner == null || owner.isBlank()) {
            throw new IllegalArgumentException("Owner is required.");
        }
        if (openingBalance < MIN_BALANCE) {
            throw new IllegalArgumentException("Opening balance is invalid.");
        }
        this.owner = owner;
        this.balance = openingBalance;
    }

    public String getOwner() {
        return owner;
    }

    public double getBalance() {
        return balance;
    }

    public void deposit(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive.");
        }
        balance += amount;
    }

    public boolean withdraw(double amount) {
        if (amount <= 0 || balance - amount < MIN_BALANCE) {
            return false;
        }
        balance -= amount;
        return true;
    }
}
