/*      Jamal Mahboob
        ScrollBar.pde           */
        
class Scrollbar {
    color scrollbarBackgroundColor = 0xFFFFFFFF;
    color scrollbarColor = 0xFF000000;
    
    int menuPos;
    int menuHeight;
    int scrollbarPos;
    int scrollbarHeight = height*0.1;
    int barPos = 0;
    int barWidth = width;
    
    Scrollbar() {
        println("Scrollbar: constructor");
        //scrollbarBackgroundColor = 0xFFFFFFFF;
        //scrollbarColor = 0xFF000000;
    }
    
    Scrollbar(int _menuPos, int _menuHeight) {
        menuPos = _menuPos;
        menuHeight = _menuHeight;
        scrollbarPos = menuPos + menuHeight + 10;
    }
    
    void moveY(int speed) {
        scrollbarPos += speed;
    }
    
    void moveX(int pos) {
        barPos = pos;
    }
    
    int getPos() {
        return scrollbarPos;
    }
    
    int getBarPos() {
        return barPos;
    }
    
    int getBarWidth() {
        return barWidth;
    }
    
    int getHeight() {
        return scrollbarHeight;
    }
    
    void setPos(int pos) {
        barPos = pos;
    }
    
    void show() {
        //println("Scrollbar: show");
        //println("Scrollbar show(): y " + scrollbarPos);
        noStroke();
        fill(scrollbarBackgroundColor);
        rect(0,scrollbarPos,width,scrollbarHeight);
        
        fill(scrollbarColor);
        rect(barPos, scrollbarPos, barWidth, scrollbarHeight);
    }
}