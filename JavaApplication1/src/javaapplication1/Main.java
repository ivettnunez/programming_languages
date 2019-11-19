package javaapplication1;

import org.jpl7.Query;
import org.jpl7.Term; 
import org.jpl7.Atom;


public class Main {
    
    public static void main(String[] args) {
        //Create mine visualization
        MinePanel gold_mine = new MinePanel();
        //Query to compile the prolog file
        Query q1 = new Query( "consult", new Term[] {new Atom("C:/Users/ASUS/Documents/NetBeansProjects/JavaApplication1/src/javaapplication1/find_path.pl")});     
        //Call the query
        System.out.println((q1.hasSolution() ? "succeeded" : "failed"));
    }
    
}
