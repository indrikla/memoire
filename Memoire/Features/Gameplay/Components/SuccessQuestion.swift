//
//  SuccessQuestion.swift
//  Memoire
//
//  Created by Risa on 23/02/25.
//

struct SuccessQuestion {
    static func getQuestion(for correctAnswer: String) -> String {
        let questions = [
            "Tell a story about \(correctAnswer). \nWhat’s a special memory you have with \(correctAnswer)?",
            "What comes to mind when you think about \(correctAnswer)? \nTell us a story about it.",
            "Have you ever had a memorable experience with \(correctAnswer)? \nWe’d love to hear about it!",
            "Tell us about a time when \(correctAnswer) was important to you. \nWhat made it special?",
            "What’s the first memory you have about \(correctAnswer)? \nShare your story!",
            "Tell a story about \(correctAnswer). \nWho did you share this memory with?",
            "What’s something meaningful about \(correctAnswer) in your life? \nTell us more!",
            "Describe a moment when \(correctAnswer) made you smile. \nWhat happened?",
            "Has \(correctAnswer) ever been part of a special tradition in your life? \nTell us more!",
            "When was the last time you experienced \(correctAnswer)? \nWhat do you remember about it?",
            "Tell a story about \(correctAnswer). \nDid you ever share this with someone important?",
            "What’s something interesting or fun about \(correctAnswer) from your past? \nWe’d love to hear it!",
            "Think back to a time when \(correctAnswer) was part of your day. \nWhat was that like?",
            "Have you ever had a surprise moment with \(correctAnswer)? \nTell us what happened!",
            "Tell a story about \(correctAnswer). \nHow did it make you feel at the time?"
        ]
        return questions.randomElement() ?? "No question found"
    }
}
