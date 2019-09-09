using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovementYSpawn : MonoBehaviour
{
    public GameObject proyectil;
    

    void Start()
    {
        
    }

    void Update()
    {
        /*if (Input.GetKey(KeyCode.A))
        {
            transform.RotateAround(this.transform.position, new Vector3(0, 1, 0), -5);
        }
        if (Input.GetKey(KeyCode.D))
        {
            transform.RotateAround(this.transform.position, new Vector3(0, 1, 0), 5);
        }*/
        if (Input.GetKeyDown(KeyCode.Space))
        {
            crearProyectil();
        }
    }

    void crearProyectil()
    {
        GameObject aux = Instantiate(proyectil, this.transform);
        this.transform.DetachChildren();
        //aux.transform.Translate(this.transform.forward);
    }
}
