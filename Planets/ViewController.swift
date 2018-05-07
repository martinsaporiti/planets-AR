//
//  ViewController.swift
//  Planets
//
//  Created by Martin Saporiti on 06/05/2018.
//  Copyright © 2018 Martin Saporiti. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {

    
    @IBOutlet weak var sceneView: ARSCNView!
    
    let configuration = ARWorldTrackingConfiguration();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints,
                                       ARSCNDebugOptions.showWorldOrigin]

        self.sceneView.autoenablesDefaultLighting = true
        self.sceneView.session.run(configuration);

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        let sun = self.buildPlanet(geometry: SCNSphere(radius: 0.35), diffuse: #imageLiteral(resourceName: "sun difusse"), specular: nil, emission: nil, normal: nil, position: SCNVector3(0, 0, -1))
        
        
        let earthParent = SCNNode()
        let venusParent = SCNNode()
        let moonParent = SCNNode()
        
        earthParent.position = SCNVector3(0,0,-1)
        venusParent.position = SCNVector3(0,0,-1)
        moonParent.position = SCNVector3(1.2,0,0)
        
        
        // Pongo a girar el sol.
        let sunRotation = self.rotation(time: 8)
        sun.runAction(sunRotation)
        
        
        // EARTH
        let earth = self.buildPlanet(geometry: SCNSphere(radius: 0.2), diffuse: #imageLiteral(resourceName: "earth day"), specular: #imageLiteral(resourceName: "earth specular"), emission: #imageLiteral(resourceName: "earth emission"), normal: #imageLiteral(resourceName: "earth normal"), position: SCNVector3(1.2, 0, 0))
        earthParent.addChildNode(earth)
        
        let earthParentRotation = self.rotation(time: 14)
        earthParent.runAction(earthParentRotation)

        let earthRotation = self.rotation(time: 8)
        earth.runAction(earthRotation)
        
        
        // VENUS
        let venus = buildPlanet(geometry: SCNSphere(radius: 0.1), diffuse: #imageLiteral(resourceName: "venus surface"), specular: nil, emission: #imageLiteral(resourceName: "venus atmosphere"),
                                normal: nil, position: SCNVector3(0.7, 0,0))

        venusParent.addChildNode(venus)
        
        let venusParentRotation = self.rotation(time: 10)
        venusParent.runAction(venusParentRotation)
        
        let venusRotation = self.rotation(time: 8)
        venus.runAction(venusRotation)
        
        
        // MOON
        let moon = buildPlanet(geometry: SCNSphere(radius: 0.05), diffuse: #imageLiteral(resourceName: "moon difusse"), specular: nil, emission: nil,
                               normal: nil, position: SCNVector3(0, 0, -0.3))
        
        let moonRotation = rotation(time: 5)
        moon.runAction(moonRotation)
        moonParent.addChildNode(moon)

        // Agrego los nodos principales al raiz.
        self.sceneView.scene.rootNode.addChildNode(sun)
        self.sceneView.scene.rootNode.addChildNode(earthParent)
        earthParent.addChildNode(moonParent)
        self.sceneView.scene.rootNode.addChildNode(venusParent)
    }
    
    
    
    
    /**
 
     */
    func rotation(time: TimeInterval) -> SCNAction {
        let rotation =  SCNAction.rotateBy(x: 0, y: CGFloat(360.degreesToRadians), z: 0, duration: time)
        let forEverRotation = SCNAction.repeatForever(rotation)
        return forEverRotation
    }

    
    
    
    func buildPlanet(geometry: SCNGeometry, diffuse: UIImage, specular: UIImage?,
                     emission: UIImage?, normal: UIImage?, position: SCNVector3) -> SCNNode{
        
        let node = SCNNode(geometry: geometry);
        node.geometry?.firstMaterial?.diffuse.contents = diffuse
        node.geometry?.firstMaterial?.specular.contents = specular
        node.geometry?.firstMaterial?.emission.contents = emission
        node.geometry?.firstMaterial?.normal.contents = normal
        node.position = position
        
        return node
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

