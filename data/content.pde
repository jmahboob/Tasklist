/*      Jamal Mahboob
        Content class           */
        
class Content {
    String value;
    
    Content() {
        value = "DEFAULT CONTENT";
    }
    
    Content(String _value) {
        value = _value;
    }
    
    void show() {
        text(value, 0, 0, width, height);
    }
    
    void show(int menuHeight, int menuPos) {
        text(value, 20, menuPos + menuHeight + 20, width - 20, height - menuHeight);
    }
}