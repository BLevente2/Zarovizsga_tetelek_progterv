public class NumberedTicket {
    private static int nextId = 1;

    private final int id;
    private final String owner;

    public NumberedTicket(String owner) {
        this.id = NumberedTicket.nextId++;
        this.owner = owner;
    }

    public int getId() {
        return id;
    }

    public String getOwner() {
        return owner;
    }

    public static int getNextId() {
        return NumberedTicket.nextId;
    }

    public static void main(String[] args) {
        NumberedTicket first = new NumberedTicket("Anna");
        NumberedTicket second = new NumberedTicket("Béla");

        System.out.println(first.getId());
        System.out.println(second.getId());
        System.out.println(NumberedTicket.getNextId());
    }
}
