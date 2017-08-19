//
//  FirstViewController.swift
//  WebConsultor
//
//  Created by Joaquín Jiménez García on 7/5/17.
//  Copyright © 2017 Joaquín Jiménez García. All rights reserved.
//

import UIKit

var urlContent = NSString()

class FirstViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var texto: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FirstViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func cargarBtn(_ sender: Any) {
        cargarWeb()
    }
    
    
    func cargarWeb(){
        // URL con la que trabajaremos
        let url = NSURL(string: "http://" + texto.text!)!
        // Tarea que proporciona apple para poder trabajar con url's devuelve
        // tres variables: los datos, la respuesta y si hubo error
        let task = URLSession.shared.dataTask(with: url as URL){ (data, response, error) -> Void in
            // Comprueba que la tarea no devolviese error y exista "data"
            if error == nil && data != nil{
                // Pasa "data" que es exadecimal a cadena de texto
                urlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! as String as String as NSString
                
                // Lo mandamos al hilo principal para que no pierda el seguimiento del WebView
                DispatchQueue.main.async(execute: {() -> Void in
                    // Pasa el contenido al WebView para que lo muestre como web y de donde
                    // coge las bases (de la propia url)
                    self.webView.loadHTMLString(urlContent as String, baseURL: url as URL)
                    self.showAlertLoading() // Llamamos a la alerta de espera
                })
                
            }else{
                print("Hay error")
                self.showAlertErr() // Llamamos a la alerta de error
            }
        }
            
        task.resume()
    }
    
    func showAlertLoading(){
        let alertController = UIAlertController(title: "Cargando Web", message: "Espera unos segundos mientras cargamos la web para ti. Gracias.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertErr(){
        let alertController = UIAlertController(title: "Error", message: "Lo sentimos. Pero ha ocurrido un error al procesar la petición de la página web. Asegúrate que has introducido una URL correcta", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        
        return true
        
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

