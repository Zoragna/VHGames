using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dammages : MonoBehaviour
{
    public GameObject dammages;

    private void OnTriggerEnter2D(Collider2D hitInfo)
    {
        punchingball punching = hitInfo.GetComponent<punchingball>();
        Destroy(gameObject);
    
        if (punching != null)
        {
            punching.take_dammage(25);
        }
    }
}
