//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
    @IBOutlet weak var imageHangman: UIImageView!
    @IBOutlet weak var buttonStartOver: UIButton!
    @IBOutlet weak var buttonGuess: UIButton!
    @IBOutlet weak var textFieldLetter: UITextField!
    @IBOutlet weak var labelGuesses: UILabel!
    @IBOutlet weak var labelCurrentState: UILabel!
    var phrase : String!
    var characterArray: [Character]!
    var numChar:Int!
    var currState:[String]!
    var currStateString: String!
    var wrongGuesses:[String]!
    var guess:String!
    var life:Int!
    var isWin:Bool!
    var correctChar:Int!

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        self.phrase = hangmanPhrases.getRandomPhrase()
        print(phrase)
        life=7
        isWin = false
        
        characterArray = Array(phrase.characters)
        currState = []
        wrongGuesses = []
        numChar = 0
        correctChar = 0


    

        for char in characterArray{
            if(char == " "){
                self.currState.append(" ")
                
            }else{
                self.currState.append("_")
                numChar = numChar+1
            }

        }


        

        
        

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool){
        
    }
    
    
    @IBAction func initializeView(labelCurrentState: UILabel) {


    }
    
    @IBAction func guessButtonClicked(buttonGuess: UIButton) {
        guess = textFieldLetter.text!.uppercaseString
        
        var charIndex = [Int]()
        var i = 0
        let alert = UIAlertView()
        
        //See if Guess is already in our wrongGuess
        if(wrongGuesses.contains(guess)){
            alert.title = "You Already Guessed This Letter!"
            alert.message = "Please Guess Other Letter"
            alert.addButtonWithTitle("O.K")
            alert.show()
            return
        }else if(currState.contains(guess)){
            alert.title = "You Already Found This Letter!"
            alert.message = "Please Guess Other Letter"
            alert.addButtonWithTitle("O.K")
            alert.show()
            return
        }
        

        //find indices of correct letter
        for char in characterArray{
            if char == Character(guess){
                charIndex.append(i)
                correctChar = correctChar+1
            }
            i++
        }
        //if user's guess is wrong
        if(charIndex.isEmpty){
            life = life-1
            wrongGuesses.append(guess)
            print(guess)
            //change image
            //var image : UIImage = UIImage(named:"hangman2")!
            //imageHangman = UIImageView(image: image)
            /*
            if(life==5){
                                    imageHangman.image = UIImage(named: "hangman3")
            */
            
            switch life{
                case 6:
                    imageHangman.image = UIImage(named: "hangman2")
                case 5:
                    imageHangman.image = UIImage(named: "hangman3")
                case 4:
                    imageHangman.image = UIImage(named: "hangman4")
                case 3:
                    imageHangman.image = UIImage(named: "hangman5")
                case 2:
                    imageHangman.image = UIImage(named: "hangman6")
                case 1:
                    imageHangman.image = UIImage(named: "hangman7")
                default:
                    imageHangman.image = UIImage(named: "hangman1")
            }
            
        }
        labelCurrentState.text = generateCurrentState(charIndex)
        labelGuesses.text = wrongGuesses.joinWithSeparator(", ")
        //if win
        if(numChar==correctChar){
            isWin = true
            alert.title = "You Won!"
            alert.message = "Please Start Over"
            alert.addButtonWithTitle("O.K")
            alert.show()
            buttonGuess.enabled = false;
        }
        if(life==0){
            alert.title = "You Lost!"
            alert.message = "Please Start Over"
            alert.addButtonWithTitle("O.K")
            alert.show()
            buttonGuess.enabled = false;
        }

    }
    
    func generateCurrentState(idx: [Int]) -> String{
        for i in idx{
            currState[i] = guess!
        }
        currStateString = currState.joinWithSeparator(" ")
        return currStateString
    }
    @IBAction func startOverButtonClicked(buttonStartOver: UIButton) {
        currState = []
        wrongGuesses = []
        for char in characterArray{
            if(char == " "){
                self.currState.append(" ")
                
            }else{
                self.currState.append("_")
                numChar = numChar+1
            }
            
        }
        life = 7
        labelCurrentState.text = currState.joinWithSeparator(" ");
        labelGuesses.text = ""
        imageHangman.image = UIImage(named: "hangman1")
        buttonGuess.enabled = true
        
    }
    

}
