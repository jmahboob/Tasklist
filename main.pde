/* @pjs transparent="true"; */

Menu topMenu = new Menu("TOP");
Menu bottomMenu = new Menu("BOTTOM");

Button b1, b2, b3;

void setup() {
    size(960,200);
    //topMenu.testMenuPopulate();
    //topMenu.addButton("TEST 1 VALUE", "TEST 1 CONTENT");
    topMenu.addButton("Welcome!",
        "The menu that you are reading this on is the first step in a series of " +
        "coding tasks that I told myself that I would do in order to keep myself fresh.\n" +
        "\nWhat you are looking at is a somewhat animated 'tasklist' that I created " +
        "using the open source java library called 'processing'.  More specifically, " +
        "this code is running the freshest stuff, processing.js\n" +
        "\nHover over the top to reveal buttons and a listing of other tasks I desparately need to finish"
    );
    
    topMenu.addButton("Migrate to git",
        "I have a bunch of my code up on a google code webpage that I wrote awhile ago which utilizes " +
        "the processing (sans js) library MSAFluid.  I was messing around with stuff and started " +
        "recreating several classic games (pong, asteroids, etc).  I need to take this code and migrate it " +
        "to something a little more current, namely git.\n" +
        "\nI also need to just set up a landing spot for all of the processing.js and other code " +
        "that I'm going to be doing in the near future"
    );
    
    topMenu.addButton("Tasklist: Progress Bar",
        "This one is pretty simple, I want to add a sort of progress bar to the tasklist, to show if things " +
        "are, you know, actually getting done..."
    );
    
    topMenu.addButton("Tasklist: Menu Scroll Bar",
        "If there are too many buttons on the tasklist then the user needs to be able to scroll back and forth " +
        "in order to access the different items."
    );
    
    topMenu.addButton("Tasklist: Text Scroll Bar",
        "If the content of a menu item extends too long then the user also needs to be able to scroll vertically " +
        "in order to read all of the text.  Alternatively we can expand the entire applet size.  That might " +
        "be difficult though"
    );
    
    topMenu.addButton("Tasklist: Hover Indicators",
        "It isn't really apparent exactly what you have to do in order to get the drop down menu on this tasklist " +
        "to appear.  I want to add a little indicator that shows the user where they have to navigate too"
    );
    
    topMenu.addButton("Resume",
        "I want to turn my resume into this amazing little java applet that is interactive with drop-down menu's "+
        "and the like.  It'll be its own page that adheres to some 960 webdesign principles and users will have " +
        "the option to download the whole thing in a much more readable format"
    );
    
    topMenu.addButton("Portfolio",
        "I need to create a very rich portfolio page using mostly web techniques, javascript and the like"
    );
    
    topMenu.addButton("Migrate Scoreboard",
        "Awhile back I created this amazing tool, a sort of scoreboard application for a Brazilian that was " +
        "purpose driven to score matches in Brazillian Jiu Jitsu tournaments.  I want to see if I can make the " +
        "app friendly with processing.js and then release it for free for anyone to use through a web client."
    );
    
    topMenu.addButton("Add Background Fade",
        "I need to add a fade out / blur to the background on the site.  When they are viewed by anyone who is " +
        "running at a screen size larger than 1024x768, some of the images show clear signs of borders.  I just want " +
        "to add a gently fade to white, radially, on all of the images so they blend into the page well"
    );
    
}

void draw() {
    //background(0xFFFFFFFF);
    //background(0,0xFFFFFF);
    //background(0,0,100,0);
    background(0x77000000);
    //line(0, height*0.2, width, height*0.2);
    /****BUTTON****/
    try{
        //b1 = new Button(100, 100, "I HATE GEORGE");
        //b2 = new Button(15, 50, "WHAT?!");
        //b3 = new Button(200, 150, "PAT! Y U NO WANT MIDNIGHT SHOWING?!");
        //b1.show();
        //b2.show();
        //b3.show();
        
        topMenu.moveMenu();
        //bottomMenu.moveMenu();
        //bottomMenu.moveMenu();
        
    } catch(e) {
        println("ERROR: " + e);
        exit();
    }}

void mouseClicked() {
    //b3.processClicked();
    topMenu.processClicked();
}

void mousePressed() {
    b3.processPressed();
}

/*void mouseOut() {
    println("OUT");
    topMenu.moveMenuTop();
    bottomMenu.moveMenuBottom();
}*/

/*void keyPressed() {
    if(keyCode == 68) {
        topMenu.debugItems();
    }
    //else println("KeyCode: " + keyCode);
}*/
