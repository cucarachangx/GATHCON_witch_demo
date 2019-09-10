using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AvatarMovement : MonoBehaviour {
    public float speed = 2f;

    [SerializeField] MonoBehaviour[] avatarInputsGOs = null;
    IAvatarInput[] avatarInputs = null;
    Rigidbody myRigidbody = null;
    Animator animator = null;

    public bool moving { get; private set; }

    // Start is called before the first frame update
    void Start() {
        myRigidbody = GetComponent<Rigidbody>();
        animator = GetComponent<Animator>();
        avatarInputs = new IAvatarInput[avatarInputsGOs.Length];
        for(int i = 0; i < avatarInputs.Length; i++) {
            avatarInputs[i] = avatarInputsGOs[i].GetComponent<IAvatarInput>();
        }
    }

    // Update is called once per frame
    void Update() {
        Vector2 movement = Vector2.zero;

        foreach(var avInp in avatarInputs) {
            if(avInp != null)
                movement += avInp.GetInput();
        }

        Vector3 vel = movement * speed;
        vel.z = vel.y;
        vel.y = 0;

        moving = (vel != Vector3.zero);

        myRigidbody.velocity = vel;

        UpdateAnimator(vel);
        UpdateRotation(vel);
    }

    void UpdateAnimator(Vector3 velocity) {

        if(Mathf.Abs(velocity.x) >= Mathf.Abs(velocity.z))
            velocity.z = 0;
        else
            velocity.x = 0;

        animator.SetFloat("Speed", velocity.magnitude);
    }

    void UpdateRotation(Vector3 velocity) {
        if(velocity.magnitude > 0)
            transform.LookAt(transform.position + velocity.normalized, Vector3.up);
    }
}
