package ch04.com.dao;

public class Person {
    private int id=20230821;
    private String name="홍길순";

    public Person(){

    }
    public int getId(){
        return id;
    }
    public String getName(){
        return name;
    }
    public void setId(int id){
        this.id = id;
    }
    public void setName(String name){
        this.name = name;
    }
}
