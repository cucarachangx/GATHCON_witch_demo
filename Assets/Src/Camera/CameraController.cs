using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    public Vector3 offsetToAvatar = Vector3.zero;

    // Update is called once per frame
    void LateUpdate()
    {
        if(Avatar.currentAvatar != null)
            transform.position = Avatar.currentAvatar.transform.position + offsetToAvatar;
    }
}
