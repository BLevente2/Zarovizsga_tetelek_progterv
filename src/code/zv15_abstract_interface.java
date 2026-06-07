interface Drawable {
    void draw();
}

interface Scalable {
    void scale(double factor);
}

abstract class Shape {
    private final String color;

    protected Shape(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public abstract double area();

    public String describe() {
        return "color=" + color + ", area=" + area();
    }
}

class Circle extends Shape implements Drawable, Scalable {
    private double radius;

    public Circle(String color, double radius) {
        super(color);
        this.radius = radius;
    }

    @Override
    public double area() {
        return Math.PI * radius * radius;
    }

    @Override
    public void draw() {
        System.out.println("draw circle");
    }

    @Override
    public void scale(double factor) {
        radius *= factor;
    }
}
