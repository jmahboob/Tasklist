/* @pjs transparent="true"; */

/*      Jamal Mahboob
        Menu Class
*/

class Menu {
    color backgroundColor = 0xFFCCCCCC;
    color borderColor = 0xFF999999;
    boolean hasBorder = false;
    String type;
    int tweenSpeed = 3;
    int scrollbarHeight = 10;
    int menuHeight = height * 0.4;
    int menuPos = (menuHeight * -1) - (scrollbarHeight);
    ArrayList items = new ArrayList();
    int selectedItem = 0;
    Scrollbar scrollbar = new Scrollbar(menuPos, menuHeight);
    
    Menu() {
        //type = "TOP";
    }
    
    Menu(String _type) {
        if(Common.DEBUG) println("Menu() constructor");
        type = _type;
        if (type == "TOP") {
            menuHeight = height * 0.4 + tweenSpeed-1;
            menuPos = (menuHeight * -1);// - (scrollbarHeight);
        }
        else if (type == "BOTTOM") {
            menuHeight = height * 0.4 + tweenSpeed;
            menuPos = height + menuHeight;
        }
        if(Common.DEBUG) println("Menu() menuHeight: " + menuHeight);
    }
    
    void testMenuPopulate() {
        addButton(new Button("Test Button 1", "DEFAULT CONTENT ONE"));
        addButton(new Button("Test Button 2", "DEFAULT CONTENT TWO"));
        addButton(new Button("Test Button 3", "DEFAULT CONTENT THREE"));
    }
    
    boolean processHover() {
        if(Common.DEBUG) println("processHover() MENU TYPE: " + type);
        switch(type) {
            case "TOP":
                if((mouseY < height * 0.2 + scrollbarHeight*4) && (mouseY != 0)) {
                    if(Common.DEBUG) println("MOUSE OVER TOP EVENT: " + mouseY);
                    return true;
                }
                return false;
            case "BOTTOM":
                if((mouseY > height * 0.8)) {
                    if(Common.DEBUG) println("MOUSE OVER BOTTOM EVENT: " + mouseY);
                    return true;
                }
                return false;
        }
    }
    
    boolean processHoverScrollbar() {
        if(mouseY < scrollbar.getPos() + scrollbar.getHeight()) {
            if(mouseY > 0) {
                        return true;
                }
        }
        return false;
    }
    
    void moveMenuTop() {
        if(processHover()) {
            if(menuPos <= -1 - tweenSpeed) {
            //if(menuPos <= 20) {                menuPos += tweenSpeed;
                scrollbar.moveY(tweenSpeed);
                for(int i = 0; i < items.size(); i++) {
                    Button b = (Button) items.get(i);
                    b.moveY(tweenSpeed);
                    items.set(i,b);
                }
                if(Common.DEBUG) println("MENU POS *INCREASED*: " + menuPos);
            }
        }
        else {
            if(menuPos >= menuHeight * -1 - scrollbarHeight) {
                menuPos -= tweenSpeed;
                scrollbar.moveY(tweenSpeed*-1);
                for(int i = 0; i < items.size(); i++) {
                    Button b = (Button) items.get(i);
                    b.moveY(tweenSpeed*-1);
                    items.set(i,b);
                }
                if(Common.DEBUG) println("MENU POS *DECREASED*: " + menuPos);
            }
        }
        
        if(processHoverScrollbar()) {
            scrollbar.setPos(mouseX - scrollbar.getBarWidth()/2);
            moveButtons(mouseX);
        }
            
        show();
    }
    
    void moveMenuBottom() {
        if(Common.DEBUG) println("menu pos bottom: " + menuPos);
        if(processHover()) {
            if(menuPos >= height * 0.8) {                menuPos -= tweenSpeed;
                if(Common.DEBUG) println("MENU POS *INCREASED*: " + menuPos);
            }
        }
        else {
            if(menuPos <= height)  {
                menuPos += tweenSpeed;
                if(Common.DEBUG) println("MENU POS *DECREASED*: " + menuPos);
            }
        } 
        show();
    }
    
    void moveMenu() {
        switch(type) {
            case "TOP":
                moveMenuTop();
                break;
            case "BOTTOM":
                moveMenuBottom();
                break;
            case "RIGHT":
                moveMenuRight();
                break;
            case "LEFT":
                moveMenuLeft();
                break;
        }
    }
    
    void moveButtons(int x) {
        float difference = buttonWidth - width;
        float divisor = difference / width;
        int movementPos = x * divisor;
        if(Common.DEBUG) println(movementPos);
        
        Button past = (Button) items.get(0);
        past.setX(20 - movementPos);
        items.set(0,past);
        
        for(int i = 1; i < items.size(); i++) {
            Button cur = (Button) items.get(i);
            cur.setX(past.getX() + past.getWidth() + 20);
            items.set(i,cur);
            past = cur;
        }
    }
    
    int addButton(Button b) {
        if(b.getHeight() > menuHeight) return -1;
        else if (items.isEmpty()) {
            b.setPosition(20, -1*b.getHeight() - scrollbarHeight - 5);
            items.add(b);
            buttonWidth = 20 + b.getWidth();
            return 1;
        }
        else {
            Button last = (Button) items.get(items.size()-1);
            int[] pos = last.getPosition();
            textFont(b.getFont(), b.getFontSize());
            b.setPosition(pos[0] + last.getWidth() + 20 + b.getBorderWidth(), -1*b.getHeight() - scrollbarHeight - 5);
            items.add(b);
            buttonWidth = b.getX() + b.getWidth() + 20;
            return 1;
        }
        return 0;
    }
    
    int addButton(String _value, String _content) {
        Button b = new Button(_value, _content);
        addButton(b);
    }
    
    void show() {
        //noStroke();
        fill(backgroundColor);
        if(!items.isEmpty()) {
            Button b = (Button) items.get(items.size()-1);
            int menuWidth = b.getX() + b.getWidth() + 200;
        }
        //stroke(0xFF000000);
        rect(0,menuPos,menuWidth,menuHeight);
        if(Common.DEBUG) println(menuWidth);
        for(int i = 0; i < items.size(); i++) {
            Button b = (Button) items.get(i);
            b.show();
        }
        if(!items.isEmpty()) {
            Button b = (Button)items.get(selectedItem);
            String toDisplay = b.getContent();
            textFont(b.getFont(), b.getFontSize());
            fill(0xFFFFFFFF);
            text(toDisplay, 20, menuPos + menuHeight + height * 0.1, width * 0.8, height * 0.8);
        }
        //Scrollbar
        scrollbar.show();
    }
    
    void debugItems() {
        println("Menu Button Elements: " + items.size());
        for(int i = 0; i < items.size(); i++) {
            println("X: " + items.get(i).x);
            println("Y: " + items.get(i).y);
            println("Value: " + items.get(i).value);
        }
    }
    
    void processClicked() {
        for(int i = 0; i < items.size(); i++) {
            Button b = (Button) items.get(i);
            if (b.processHover()) {
                if(Common.DEBUG) println("The Button " + b.getValue() + " thinks that George is super awesome.");
                selectedItem = i;
                if(Common.DEBUG) println("Selected Menu Item Is: " + selectedItem);
            }
        }
    }
    
}
