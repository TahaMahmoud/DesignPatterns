// Command Pattern

protocol Command {
    func execute()
}

class JoystickInvoker {
    
    var command: Command?
    
    func setCommand(command: Command) {
        self.command = command
    }
    
    func doAction() {
        command?.execute()
    }
}

class LongPass: Command {
    
    var player = Player()

    func execute() {
        player.doLongPass()
    }
    
}

class Tackling: Command {
    
    var player = Player()

    func execute() {
        player.doTackling()
    }
    
}

class Player {
    
    func hasBall() -> Bool {
        return true
    }
    
    func doLongPass() {
        print("Doing LongPass")
    }
    
    func doTackling() {
        print("Doing Tackling")
    }
    
}

let joystickInvoker = JoystickInvoker()
let player = Player()

if player.hasBall() {
    joystickInvoker.setCommand(command: LongPass())
}
else {
    joystickInvoker.setCommand(command: Tackling())
}

joystickInvoker.doAction()
