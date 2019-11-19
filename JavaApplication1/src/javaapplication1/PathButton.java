package javaapplication1;

import javax.swing.JButton;
import javax.swing.ImageIcon;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.lang.Integer;
import org.jpl7.Query;
import org.jpl7.Term;
import org.jpl7.Variable;

public class PathButton extends JButton implements ActionListener{
    ImageIcon MineWall;
    ImageIcon Collapse;
    ImageIcon FootPrint;
    MinePanel GoldMine;
    int pos;
    byte value = 0;
    
    /*
    -1: nothing
     0: mine
     1: collapse
     2: path away
    */
    
    public PathButton(MinePanel m){
        MineWall  = new ImageIcon(this.getClass().getResource("road.jpg"));
        Collapse  = new ImageIcon(this.getClass().getResource("collapse.png"));
        FootPrint = new ImageIcon(this.getClass().getResource("footprint.jpg"));
        GoldMine = m;
        this.addActionListener(this);    
    }
    
    @Override
    public void actionPerformed(ActionEvent e){        
               
        value++;
        value%=4;
        switch(value){
            case 0:
                setIcon(MineWall);
                break;
                
            case 1:               
                setIcon(Collapse);
                //System.out.println("Collapse in " + this.pos);
                
                //Variable to save the response from the query
                java.util.Map<String,Term>[] res;       
                //Variable filled by the predicate with the path to go out from the mine
                Variable path = new Variable("Path");
                //Term object to handle the list
                Term term;
                //Create ldfs call
                Query q3 = new Query("ldfs", new Term[]{new org.jpl7.Integer(this.pos),new org.jpl7.Integer(99),new org.jpl7.Integer(20), path});
                
                res = q3.allSolutions();
                
                try{  
                    term = res[0].get("Path");
                    
                    for (Term oneTerm : term.toTermArray()){
                        //System.out.println(oneTerm);
                        String temp = oneTerm.toString();
                        int current_node = Integer.parseInt(temp);
                        //Set all button's value to 1 and clicked them to change the icon image
                        if(current_node != this.pos){
                            GoldMine.mineMap[current_node].value = 1;
                        }
                        GoldMine.mineMap[current_node].doClick();
                    }
                    
                }
                catch(Exception ex){            
                    System.out.println("Sorry, you are going to die");       
                }
                break;
                
            case 2:
                setIcon(FootPrint);
                break;
            case 3:
                //GoldMine.resetMine1();// Este reset seria util cuando dan click donde hay huellas
                DrawMine.getOriginalMine(GoldMine); //Pero hace cosas raras
                this.value = 0;
                GoldMine.mineMap[this.pos].doClick();
                break;
        }
    }
    
}
