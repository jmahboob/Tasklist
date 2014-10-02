/* @pjs transparent="true"; */

/*      Jamal Mahboob
        Button Class
*/

class Button {
    PFont font = loadFont("Courier New");
    int x, y;
    String value = "Uninitialized Value";
    String content = "DEFAULT CONTENT";
    boolean border = true;
    boolean curved = true;
    int borderSize = 3;
    int size = 12;
    /*color borderColor = 0xFFFFFF;
    color backgroundColor = 0xAAAAAA;
    color hoverBackgroundColor = 0x666666;
    color hoverBorderColor = 0xFFFFFF;*/
    
    color borderColor = #000000;
    color backgroundColor = #AAAAAA;
    color hoverBackgroundColor = #CCCCCC;
    color hoverBorderColor = #FFFFFF;
    color clickBackgroundColor = #FFFFFF;
    color clickBorderColor = #FFFFFF;
    
    color textColor = #000000;
    int padding = 5;
    //int paddingBottomBuffer = size / 4;
    
    Button() {        textAlign("CENTER");
        x = width / 2;
        y = height / 2;        textFont(font, size);
    }
    Button(String text) {
        value = text;
        x = 0;
        y = 0;
        textFont(font, size);
    }
    Button(String _value, String _content) {
        value = _value;
        content = _content;
    }
    Button(int _x, int _y, String text) {
        textAlign("CENTER");
        x = _x;
        y = _y;
        value = text;
        textFont(font, size);
    }
    
    boolean processHover() {
        float[] c1, c2, c3, c4 = new float[2];
        c1 = [x - padding, y - textAscent() - padding];
        c2 = [x + textWidth(value) + padding, y - textAscent() - padding];
        c3 = [x + textWidth(value) + padding, y + padding * 2];
        c4 = [x - padding, y + padding * 2];
        
        if (mouseX > c1[0]) {
            if(mouseX < c2[0]) {
                if(mouseY > c1[1]) {
                    if(mouseY < c3[1]) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
    
    void processClicked() {
        if(processHover()) {
            if(Common.DEBUG) println("Clicked: " + value);
            println("The Button " + value + " thinks George is super awesome.");
        }
    }
    
    void show() {
        textSize(size);
        if (border) {
            float[] c1, c2, c3, c4 = new float[2];
            /*c1 = [x - padding, y + padding];
            c2 = [x + textWidth(value) + padding, y + padding];
            c3 = [x + textWidth(value) + padding, y - textDescent() - padding];
            c4 = [x - padding, y - textDescent() - padding];*/
        
            c1 = [x - padding, y - textAscent() - padding];
            c2 = [x + textWidth(value) + padding, y - textAscent() - padding];
            c3 = [x + textWidth(value) + padding, y + padding * 2];
            c4 = [x - padding, y + padding * 2];
            
            /*line(0, y - textAscent() - padding, width, y - textAscent() - padding);
            line(x - padding, 0, x - padding, height);
            line(x + textWidth(value) + padding, 0, x + textWidth(value) + padding, height);
            line(0, y + padding *2, width, y + padding*2);*/
            if (!curved) {
                stroke(borderColor);
                fill(backgroundColor);
                quad(       c1[0], c1[1],
                            c2[0], c2[1],
                            c3[0], c3[1],
                            c4[0], c4[1])
            }
            else {
                if(processHover() && mousePressed) {
                    fill(clickBackgroundColor);
                    stroke(clickBorderColor);
                }
                else if (processHover()) {
                    fill(hoverBackgroundColor);
                    stroke(hoverBorderColor);
                }
                else { 
                    fill(backgroundColor);
                    stroke(borderColor);
                }
                //beginShape();
                //Determine the HEIGHT of the box
                box_height = c4[1] - c1[1];
                //Determine the WIDTH of the box
                box_width = c2[0] - c1[0];
                //Create an arbitrary RADIUS object
                box_radius = box_height / 5;
                //Create 4 new coordinate points
                float[] _c1 = [0,0];                float[] _c2 = [0,0];
                float[] _c3 = [0,0];
                float[] _c4 = [0,0];
                arrayCopy(c1, _c1, c1.length());
                arrayCopy(c2, _c2, c2.length());
                arrayCopy(c3, _c3, c3.length());
                arrayCopy(c4, _c4, c4.length());
                //Subtract amounts to create points for bezier curves to connect to
                /*_c1[0] += box_width * 0.2; //move x to the right
                c1[1] += box_height * 0.2; //move y down
                _c2[0] -= box_width * 0.2; //move x to the left
                c2[1] += box_height * 0.2; //move y down
                
                _c3[0] -= box_width * 0.2; //move x to the left
                c3[1] -= box_height * 0.2; //move y up
                _c4[0] += box_width * 0.2; //move x to the right
                c4[1] -= box_height * 0.2; //move y up*/
                
                //Draw, oh god I hope it works
                /*line(_c1[0], _c1[1], c1[0], c1[1]);
                line(_c2[0], _c2[1], c2[0], c2[1]);
                line(_c3[0], _c3[1], c3[0], c3[1]);
                line(_c4[0], _c4[1], c4[0], c3[1]);*/
                
                //noFill();
                beginShape();
                    strokeWeight(borderSize);
                    vertex(c1[0]+box_radius, c1[1]);
                    vertex(c2[0]-box_radius,c2[1]);
                    bezierVertex(c2[0]-box_radius,c2[1],
                                    c2[0],c2[1],
                                    c2[0],c2[1]+box_radius);
                    vertex(c2[0],c2[1]+box_radius);
                    vertex(c3[0], c3[1]-box_radius);
                    bezierVertex(c3[0], c3[1]-box_radius,
                                    c3[0], c3[1],
                                    c3[0]-box_radius, c3[1]);
                    vertex(c3[0]-box_radius,c3[1]);
                    vertex(c4[0]+box_radius,c4[1]);
                    bezierVertex(c4[0]+box_radius, c4[1],
                                    c4[0], c4[1],
                                    c4[0], c4[1]-box_radius);
                    vertex(c4[0],c4[1]-box_radius);
                    vertex(c1[0], c1[1]+box_radius);
                    bezierVertex(c1[0], c1[1]+box_radius,
                                    c1[0], c1[1],
                                    c1[0]+box_radius, c1[1]);
                endShape(CLOSE);
                /*noStroke();                fill(backgroundColor);
                quad(       c1[0]+box_radius, c1[1]+ceil(borderSize/2),
                            c2[0]-box_radius, c2[1]+ceil(borderSize/2),
                            c3[0]-box_radius, c3[1]-ceil(borderSize/2),
                            c4[0]+box_radius, c4[1]-ceil(borderSize/2));
                            
                quad(       c1[0]+ceil(borderSize/2), c1[1]+box_radius,
                            c2[0]-ceil(borderSize/2), c2[1]+box_radius,
                            c3[0]-ceil(borderSize/2), c3[1]-box_radius,
                            c4[0]+ceil(borderSize/2), c4[1]-box_radius);
                ellipse(        c1[0]+box_radius, c1[1]+box_radius, box_radius+ceil(borderSize/2), box_radius+ceil(borderSize/2));
                ellipse(        c2[0]-box_radius, c2[1]+box_radius, box_radius+ceil(borderSize/2), box_radius+ceil(borderSize/2));
                ellipse(        c3[0]-box_radius, c3[1]-box_radius, box_radius+ceil(borderSize/2), box_radius+ceil(borderSize/2));
                ellipse(        c4[0]+box_radius, c4[1]-box_radius, box_radius+ceil(borderSize/2), box_radius+ceil(borderSize/2));*/
                /*ellipse(        c1[0]+box_radius, c1[1]+box_radius, box_radius, box_radius);
                ellipse(        c2[0]-box_radius, c2[1]+box_radius, box_radius, box_radius);
                ellipse(        c3[0]-box_radius, c3[1]-box_radius, box_radius, box_radius);
                ellipse(        c4[0]+box_radius, c4[1]-box_radius, box_radius, box_radius);*/
            }
        }
            stroke(textColor); fill(textColor);
        text(value, x, y);
    }
 
    int getHeight() {
        return textDescent(value) - textAscent(value);
    }
    
    int getWidth() {
        return textWidth(value);
    }
    
    int[] getPosition() {
        int[] toReturn = new int[2];
        toReturn[0] = x;
        toReturn[1] = y;
        return toReturn;
    }
    
    void setPosition(int _x, int _y) {
        x = _x;
        y = _y;
    }
    
    void setX(int _x) {
        x = _x;
    }
    
    void setY(int _y) {
        y = _y;
    }
    
    void setContent(String _content) {
        content = _content;
    }
    
    String getContent() {
        return content;
    }
 
    int getX() {
        return x;
    }
    
    int getY() {
        return y;
    }
 
    void moveX(int _x) {
        x += _x;
    }
          
    void moveY(int _y) {
        y += _y;
    }
    
    String getValue() {
        return value;
    }
    
    int getBorderWidth() {
        return borderSize;
    }
    
    PFont getFont() {
        return font;
    }
    
    int getFontSize() {
        return size;
    }
}
