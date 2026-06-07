class Animal {
    private final String name;

    public Animal(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void makeSound() {
        System.out.println("generic animal sound");
    }
}

class Dog extends Animal {
    public Dog(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println("bark");
    }
}

class Cat extends Animal {
    public Cat(String name) {
        super(name);
    }

    @Override
    public void makeSound() {
        System.out.println("meow");
    }
}

public class InheritancePolymorphismDemo {
    public static void main(String[] args) {
        Animal first = new Dog("Morzsa");
        Animal second = new Cat("Cirmos");

        first.makeSound();
        second.makeSound();

        System.out.println(first.getName());
        System.out.println(second.getName());
    }
}
