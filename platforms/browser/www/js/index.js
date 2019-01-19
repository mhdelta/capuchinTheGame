document.addEventListener('deviceready', function() {
    var config = {
        type: Phaser.WEBGL,
        width: 840,
        height: 650,
        parent: 'game',
        physics: {
            default: 'arcade',
            arcade: {
                gravity: { y: 300 },
                debug: false
            }
        },
        scene: {
            preload: preload,
            create: create,
            update: update,
            render: render
        },
        useTicker: true
    };
    
    const ms = 1000;
    var game = new Phaser.Game(config);
    var platforms;
    var xrails = [210, 335, 470, 595]
    var borders = {
        leftBorder: 370,
        rigthBorder: 600
    }


    function preload() {
        this.load.image('back', 'img/background.png');
        this.load.image('rock', 'img/rock.png');
    }
    
    function create() {
        this.clock = 0;
        this.add.image(400, 300, 'back');
        platforms = this.physics.add.group();
        
        var r1 = this.add.rectangle(400, 500, 575, 20, 0x0);

    }

    function update() {
        if (Math.round(this.clock) != Math.round(this.time.now/ms)) {
            this.clock = this.time.now/ms    
            if (Math.round(this.clock) % 4 == 0) {
                platforms.create(470, -200, 'rock');
                platforms.create(595, -300, 'rock');
                platforms.create(210, 250, 'rock');
                platforms.create(335, 250, 'rock');
            }
        }
    }

    function render() {
    }    
});