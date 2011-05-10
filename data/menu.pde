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
                if(Common.DEBUG) println("The Button " + b.getValue() + " thinks that George Rabil is super gay.");
                selectedItem = i;
                if(Common.DEBUG) println("Selected Menu Item Is: " + selectedItem);
            }
        }
    }
    
    void theMotherFuckingFlash() {
        Button b = (Button) items.get(0);
        b.setContent("The Motherfucking Flash" +
        "Now, I don't know how many of you dogs of the scurviest sea read comics, but I do a big pile of comics. " +
        "One thing that blows my mind is how completely insane the powers in the DC universe are. Look at Superman." + 
        "This guy has more powers than French restaurants have ways to say 'your taste in wine is atrocious'. He has " +
        "powers to do with every part of his body and then some. He forgets powers sometimes. He can shoot heat rays ");
        /*out of his eyes, frost breath from his mouth and red son radiation from his ass. He's that sort of crazy dude. 
        All because he absorbs solar radiation." + 
        "Look at Batman. His power? The anti-power. Sure, he should be some tame, kung fun master of not much, but 
        instead he's the hottest shit to ever shit on a plate. You got a power? He'll find your weakness and give 
        you seizures or heart attacks. He'll light you on fire when you're sleeping or make you recharge your green 
        lantern ring in the power outlet. Ten thousand volts of fuck you batman. That's Batman. " +
        "But the fucking Flash, my god, my FUCKING GOD, this man has the greatest powers of all. If Superman's 
        powers are being sucked off by twin super models and batman coming home to discover your wife is not only 
        bisexual but has two friends she wants you to 'get in on' then the Flash is an orgy with a thousand women 
        who also want to pay your World of Warcraft billing. And click the mouse for you. This man is just that 
        fucking hot. They have to power him down in the comics half the time just to keep him from doing everyone 
        else's job. " +
        "Ok first off, he can travel at lightspeed. Mother fuck! Not only does he travel at lightspeed, but time 
        slows down for him. So he feels like he's having a casual jog or reading the paper, meanwhile, his feet are
         moving so fast you can hear him coming from Montana while he's already gotten to Arizona. That's fucking 
         fast. But wait! The ability to move at Lightspeed just isn't fucking enough!" +
        "I know! Christ this guy can punch you so many times in a second you've been hit five times in the cock and 
        two times everywhere else. You think you're about to fight the Flash and then it hits you, for the last split 
        second he's beaned your beanbags with more blows than you had sperm. But no, there's more!" +
        "The Flash can also vibrate through walls. Now last I heard, you can not move so fast you can vibrate through 
        walls, so what actually happens is the Flash is so fast he can pick and choose the movement of his individual 
        molecules and move them through other solid objects, phasing through solid matter like it ain't no thing.
         I mean you think a guy who runs at lightspeed would run into shit but no, the Flash just goes right through 
         them. To top that with a cherry and some whipped cream (which the Flash made in like a millisecond, fucker)
          he can selectively choose to cause objects to be 'okay' afterwards or FUCKING EXPLODE. That's right. He can 
          run through you and make you blow up by transfering kinetic energy into you. Like Jesus. IT's bad enough you 
          can't hit this guy, but he doesn't even have to punch you. Now your testicles have exploded and you're 
          thinking you're about to hit him. Jesus? Just give it up. He's the fucking Flash." +
        "Now imagine that somehow there's someone who can get around the Flash blowing your balls up secret ninja 
        technique. Ok. He can also control the flow of energy between objects. This power makes no sense but basically 
        he can throw a rock at you, and you think it's going slow and then he's like WHOOHOOO WIZARDLY FLASH POWERS and 
        bam it's going at lightspeed. So he can throw seven million rocks at you in a second then make them all goes 
        different speeds thus striking your nads with seven million rocks one after the other." +
        "But wait! There's more! He can also take energy from the very power of speed and make clothes out of it. Yes.
         Flash makes his pants out of GOES FAST. The man is so fast he can make Flash pants that GOES FAST go right into. 
         I don't even start to understand the physics of that but basically SPEED == REALLY TIGHT UNDERWEAR AND COOL 
         LIGHTNING THINGIES OVER THE EAR. You would think this is the end of it but ok let's say Flash is fighting Superman 
         and shit he's going to lose and FUCK how is Superman THIS fucking strong? I don't know he must be Superman 
         fused with Batman into some sort of guy with tons of plans on how to punch you far harder than anyone else 
         ok to end it off the Flash can GO BACK OR FORWARD IN TIME ON COMMAND." +
        "How do you beat this dude? You're thinking you're hashing him good, laying down the beatdown, missing your 
        balls and suddenly BAM YOUR MOM FELL DOWN THE STAIRS TWENTY YEARS AGO and there's a dent in your forehead and 
        Superman not thunk so gud no more. Actually she didn't fall down the stairs the Flash put speed into them so 
        they fell up her! Fuck you Flash! You moved the stairs to Soviet fucking russia! RUSH-A! Bitch." +
        "Oh, and lastly his greatest power is he isn't fast in bed. He takes it slow and gets all the ladies with his
         superpowers then actually satisfies them in the sack. Who the Hell is this guy? You'd think he could AT LEAST
          be a premature ejaculator since his penis is moving at lightspeed but NOOOO he's even good in bed."
        "And that, ladies and gentlemen, is why Wolverine sucks cock and should go die in a freak greasefire.");*/
    }
}