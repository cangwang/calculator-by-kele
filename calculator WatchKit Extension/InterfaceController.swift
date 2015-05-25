//
//  InterfaceController.swift
//  calculator WatchKit Extension
//
//  Created by air on 15/5/21.
//  Copyright (c) 2015年 air. All rights reserved.
//

import WatchKit
import Foundation

enum CalcType {
    case Devide
    case Mulitply
    case Subtract
    case Add
    case Nil
}

class InterfaceController: WKInterfaceController {
    //显示数值和结果的文本标签
    @IBOutlet weak var labResult: WKInterfaceLabel!
    
    //结果
    var strResult:String = "0"
    //计算方法
    var type:CalcType = CalcType.Nil
    //声明左值
    var leftvalue:Double?
    //声明右值
    var rightvalue:Double?
    //是否开始计算，true标示进行右值设置，false标示处于左值阶段
    var isCalc:Bool = false
    
    //按钮0点击
    @IBAction func btn0Tap() {
        onAddNum(0)
    }
    
    //按钮1点击
    @IBAction func btn1Tap() {
        onAddNum(1)
    }
    
    //按钮2点击
    @IBAction func btn2Tap() {
        onAddNum(2)
    }
    
    //按钮3点击
    @IBAction func btn3Tap() {
        onAddNum(3)
    }
    
    //按钮4点击
    @IBAction func btn4Tap() {
        onAddNum(4)
    }
    
    //按钮5点击
    @IBAction func btn5Tap() {
        onAddNum(5)
    }
    
    //按钮6点击
    @IBAction func btn6Tap() {
        onAddNum(6)
    }
    
    //按钮7点击
    @IBAction func btn7Tap() {
        onAddNum(7)
    }
    
    //按钮8点击
    @IBAction func btn8Tap() {
        onAddNum(8)
    }
    
    //按钮9点击
    @IBAction func btn9Tap() {
        onAddNum(9)
    }
    //增加数值的方法，并随时更新左值还是右值
    //需要通过isCalc来判断，是左值还是右值
    func onAddNum(num:Int){
        if !isCalc {
            //当处于左值阶段，同时左值又试nil，需要文本标签的字符串变为0
            if leftvalue == nil {
                strResult = "0"
            }
            onSetNum(num)
            //更新左值
            leftvalue = (strResult as NSString).doubleValue
            
        }else {
            if rightvalue == nil {
                strResult = "0"
            }
            onSetNum(num)
            //更新右值
            rightvalue = (strResult as NSString).doubleValue
        }
        labResult.setText(strResult)
    }
    
    func onSetNum(num:Int){
        if strResult == "0" {
            strResult = "\(num)"
        }else {
            //不为0，将字符串进行连接
            strResult += "\(num)"
        }
    }
    
    //按钮清楚点击
    @IBAction func btnCTap() {
        strResult = "0"
        type = CalcType.Nil
        leftvalue = nil
        rightvalue = nil
        labResult.setText(strResult)
    }
    
    //按钮正负翻转点击
    @IBAction func btnNTap() {
        var num = (strResult as NSString).doubleValue
        strResult = "\(num * -1)"
        labResult.setText(strResult)
    }
    
    //按钮除以100点击
    @IBAction func btnHTap() {
        var num = (strResult as NSString).doubleValue
        strResult = "\(num / 100)"
        labResult.setText(strResult)
    }
    
    
    //按钮除点击
    @IBAction func btnDTap() {
        onToRight()
        type = CalcType.Devide
        
    }
    
    //按钮乘点击
    @IBAction func btnMTap() {
        onToRight()
        type = CalcType.Mulitply
    }
    
    //按钮减点击
    @IBAction func btnSTap() {
        onToRight()
        type = CalcType.Subtract
    }
    
    //按钮加点击
    @IBAction func btnATap() {
        onToRight()
        type = CalcType.Add
    }
    
    //按钮等号点击
    @IBAction func btnRTap() {
        //当算式进行到右值设置时，这时候才执行运算，同时将禁毒恢复到左值设置
        if isCalc {
            onExecute(rightvalue!)
            isCalc = false
        }
    }
    //计算方法
    func onExecute(newValue:Double){
        switch type {
        case .Add:
            leftvalue! += newValue
        case .Subtract:
            leftvalue! -= newValue
        case .Mulitply:
            leftvalue! *= newValue
        case .Devide:
            leftvalue! /= newValue
        default:
            return
        }
        strResult = "\(leftvalue!)"
        
        if strResult.componentsSeparatedByString(".").last == "0" {
            
        }
        
        labResult.setText(strResult)
        leftvalue = nil
    }
    
    //左值转到右值的设置
    func onToRight() {
        //当处在左值设置时，跳转到右值设置，并记录左值，同时将右值设为nil
        if !isCalc {
            leftvalue = (strResult as NSString).doubleValue
            isCalc = true
            rightvalue = nil
        }
        
    }
    
    //按钮点点击
    @IBAction func btnPTap() {
        //以.为分隔符判断，是否存在两个地方
        if strResult.componentsSeparatedByString(".").count < 2{
            strResult += "."
        }
        labResult.setText(strResult)
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}


