package javaapplication1;

import javax.swing.JPanel;
import javax.swing.JFrame;
import java.awt.GridLayout;


public class MinePanel extends JFrame{
    
    JPanel minePanel = new JPanel();
    //Array of button objects
    PathButton mineMap[] = new PathButton[100];
    //This array represents the mine map. Numbers are the assigned id for each node
    int mineNodes[] = {1,4,6,11,13,14,16,21,23,26,27,28,29,
                  31,32,33,35,36,40,41,43,46,47,48,
                  53,58,63,64,65,66,67,68,69,
                  70,71,72,73,75,79,85,95,96,97};
    
    @SuppressWarnings("LeakingThisInConstructor")
    public MinePanel(){

        //Panel set up 
        super("JavaApplication1");
        setSize(400,400);
        setResizable(false);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        minePanel.setLayout(new GridLayout(10,10));
        
        //Fill the grid panel with buttons objects
        for(int i=0; i<mineMap.length; i++){
            mineMap[i] = new PathButton(this);
            mineMap[i].pos = i;
            minePanel.add(mineMap[i]);
        }
        
        //resetMine1();
        
        //Calling getOriginalMine method to draw the mine map into the panel using parallelism
        DrawMine.getOriginalMine(this);
        //Add panel to the frame
        add(minePanel);        
        setVisible(true);
    }
    
    public boolean isMinePath(int i){
        for(int j=0; j < mineNodes.length; j++){
            if(i == mineNodes[j]){
                return true;
            }
        }
        return false;
    }
    
    public void resetMine1(){
        
        for(int i=0; i < mineMap.length; i++){
            mineMap[i].value = -1;
            if(isMinePath(i)){
                  mineMap[i].doClick();
            }
            else{
                mineMap[i].setEnabled(false);                
            }
        }
    }
    
}
