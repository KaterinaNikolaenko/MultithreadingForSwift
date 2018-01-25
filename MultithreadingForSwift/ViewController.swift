//  ViewController.swift
//  MultithreadingForSwift
//
//  Created by Katerina on 22.01.18.
//  Copyright © 2018 Katerina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //UI
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doLongAsyncTaskInSerialQueue() {
        let serialQueue = DispatchQueue(label: "com.queue.Serial")
        for i in 1...5 {
            print("aaaaa \(i) \(Thread.isMainThread)")
            serialQueue.async {
                if Thread.isMainThread{
                    print("\(i) task running in main thread")
                }else{
                    print("\(i) task running in background thread")
                }
                let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                let _ = try! Data(contentsOf: imgURL)
                print("\(i) completed downloading")
            }
            print("\(i) executing \(Thread.isMainThread)")
        }
    }
    
    @IBAction func doLongSyncTaskInSerialQueue() {
        let serialQueue = DispatchQueue(label: "com.queue.Serial")
        for i in 1...5 {
            print("aaaaa \(i) \(Thread.isMainThread)")
            serialQueue.sync {
                if Thread.isMainThread{
                    print("\(i) task running in main thread")
                }else{
                    print("\(i) task running in background thread")
                }
                let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                let _ = try! Data(contentsOf: imgURL)
                print("\(i) completed downloading")
            }
            print("\(i) executing \(Thread.isMainThread)")
        }
    }
    
    @IBAction func doLongASyncTaskInConcurrentQueue() {
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        for i in 1...5 {
            print("aaaaa \(i) \(Thread.isMainThread)")
            concurrentQueue.async {
                if Thread.isMainThread{
                    print("\(i) task running in main thread")
                }else{
                    print("\(i) task running in background thread")
                }
                let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                let _ = try! Data(contentsOf: imgURL)
                print("\(i) completed downloading")
            }
            print("\(i) executing \(Thread.isMainThread)")
        }
    }
    
    @IBAction func doLongSyncTaskInConcurrentQueue() {
        let concurrentQueue = DispatchQueue(label: "com.queue.Concurrent", attributes: .concurrent)
        for i in 1...5 {
            print("aaaaa \(i) \(Thread.isMainThread)")
            concurrentQueue.sync {
                
                if Thread.isMainThread{
                    print("\(i) task running in main thread")
                }else{
                    print("\(i)  task running in background thread")
                }
                
                let imgURL = URL(string: "https://upload.wikimedia.org/wikipedia/commons/0/07/Huge_ball_at_Vilnius_center.jpg")!
                let _ = try! Data(contentsOf: imgURL)
                print("\(i) completed downloading")
            }
            print("\(i) executed \(Thread.isMainThread)")
        }
    }

    @IBAction func NSOperationQueue(_ sender: Any) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 4
        for i in 1...100 {
            queue.addOperation(op(n: "AJ \(i)", label: textLabel))
        }
    }
}

class op: Operation {
    var nameV: String
    var labelOp: UILabel
    
    init(n: String, label: UILabel) {
        nameV = n
        labelOp = label
    }
    override func main() {
        print("Thread \(nameV)")
        
        let mainThread = OperationQueue.main
        mainThread.addOperation {
            self.labelOp.text = "\(self.nameV)"
        }
    }
}

