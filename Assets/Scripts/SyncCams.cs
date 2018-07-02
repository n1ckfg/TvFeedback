using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SyncCams : MonoBehaviour {

    public Camera sourceCam;
    public Camera[] destCam;

	private void Start () {
		foreach (Camera cam in destCam) {
            cam.allowHDR = sourceCam.allowHDR;
            cam.allowMSAA = sourceCam.allowMSAA;
            cam.useOcclusionCulling = sourceCam.useOcclusionCulling;
            cam.allowDynamicResolution = sourceCam.allowDynamicResolution;
            cam.nearClipPlane = sourceCam.nearClipPlane;
            cam.farClipPlane = sourceCam.farClipPlane;
        }
	}

}
