/*
Class to draw all mine paths using parallelism.
Receives a Mine object to draw all mine paths into his panel.
The panel is initially filled by buttons object. Those buttons are
modified to represent by image icons all of the paths in the mine map
*/
package javaapplication1;

import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class DrawMine  extends RecursiveAction{
    MinePanel mineSource;
    int mineStart;
    int mineLength;
    
    public DrawMine(MinePanel m, int s, int l){
        mineSource = m;
        mineStart = s;
        mineLength = l;
    }
    
    protected void compute(){
        if(mineLength <= 10){
            computeDirectly();
            return;
        }
        else{
            int newLength = mineLength/2;
            invokeAll(new DrawMine(mineSource, mineStart, newLength), new DrawMine(mineSource, mineStart+newLength, mineLength-newLength));
        }            
    }
    
    protected void computeDirectly(){
        for(int index = mineStart; index < mineStart+mineLength; index++){
            mineSource.mineMap[index].value = -1;
            if(mineSource.isMinePath(index)){
                mineSource.mineMap[index].value = 0;
                mineSource.mineMap[index].setIcon(mineSource.mineMap[index].MineWall);
                //mineSource.mineMap[index].doClick();
            }
            else{
                mineSource.mineMap[index].setEnabled(false);                
            }
        
        }
    }
    
    public static void getOriginalMine(MinePanel srcMine){
        
        DrawMine r = new DrawMine(srcMine, 0, srcMine.mineMap.length);
        ForkJoinPool pool = new ForkJoinPool();
 
        long startTime = System.currentTimeMillis();
        pool.invoke(r);
        long endTime = System.currentTimeMillis();
 
        //System.out.println("Parallel version took " + (endTime - startTime) + " milliseconds.");
    }
    
}
