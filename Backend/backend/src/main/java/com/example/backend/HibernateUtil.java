package com.example.backend;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistry;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;



/**
 * @author imssbora
 */
public class HibernateUtil {
  private static StandardServiceRegistry registry;
  private static SessionFactory sessionFactory;

  public static SessionFactory getSessionFactory() {
    if (sessionFactory == null) {
      try {
        StandardServiceRegistryBuilder registryBuilder = 
            new StandardServiceRegistryBuilder();

        Map<String, String> settings = new HashMap<>();
        
        
       
    
    

        registryBuilder.applySettings(settings);

        registry = registryBuilder.build();

        MetadataSources sources = new MetadataSources(registry)
            .addAnnotatedClass(Dog.class);

        Metadata metadata = sources.getMetadataBuilder().build();

        sessionFactory = metadata.getSessionFactoryBuilder().build();
      } catch (Exception e) {
        System.out.println("SessionFactory creation failed");
        if (registry != null) {
          StandardServiceRegistryBuilder.destroy(registry);
        }
      }
    }
    return sessionFactory;
  }

  public static void shutdown() {
    if (registry != null) {
      StandardServiceRegistryBuilder.destroy(registry);
    }
  }
}