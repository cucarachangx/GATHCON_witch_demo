using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VenenoPocion : Drop {

    public Vector3 XYZOffset = Vector3.zero;
    public int venenoPocionCount = 1;
    [Space]
    [SerializeField] GameObject onGrabFxPrefab = null;

    protected override void OnGrab(Avatar avatar) {
        base.OnGrab(avatar);
                                                                //Ponele que esto esta bien
        GameObject fx = Instantiate<GameObject>(onGrabFxPrefab, avatar.transform.position + XYZOffset, Quaternion.identity);
        Destroy(fx, 2f);
    }

}
