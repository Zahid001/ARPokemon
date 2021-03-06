//
//  ViewController.swift
//  ARPokemon
//
//  Created by Md. Zahidul Islam Mazumder on 24/10/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("i")
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon", bundle: Bundle.main)
        {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
            print("images added")
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor{
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.6)
            let planeNode = SCNNode(geometry: plane)
            //planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
            
            print(imageAnchor.name)
            
            if imageAnchor.name == "evee_card"{
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn"){
                    if let pokeNode = pokeScene.rootNode.childNodes.first{
                        //planeNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            if imageAnchor.name == "oddish"{
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn"){
                    if let pokeNode = pokeScene.rootNode.childNodes.first{
                        //planeNode.eulerAngles.x = .pi/2
                        planeNode.addChildNode(pokeNode)
                    }
                }
            }
            
            
            
        }
        
        return node
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
