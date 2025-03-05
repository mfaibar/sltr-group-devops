# **High Level Architecture - Deployment Workflow**

## **Deskripsi Arsitektur**
Arsitektur ini dirancang untuk menjalankan aplikasi berbasis Flask yang dikemas dalam Docker, dikelola melalui CI/CD dengan GitHub Actions, dan dideploy ke Kubernetes.

---

## **1. Simple Coding (Flask App)**
Aplikasi memiliki satu route `/welcome/{nama}` yang dikembangkan dengan Flask dan berjalan di port 5000.

```
                        +-------------------+
                        |       Users       |
                        +--------+----------+
                                 |
                                 v
                   +---------------------------+
                   |   Flask Web Application   |
                   |  (Running on Port 5000)   |
                   +---------------------------+
```

---

## **2. Container - Docker**
Aplikasi Flask dikemas dalam **Docker Image** dan dijalankan dalam container.

```
                        +-------------------+
                        |  Docker Container |
                        |  (Flask App)      |
                        +--------+----------+
                                 |
                                 v
                   +---------------------------+
                   |   Docker Engine           |
                   |   (Port Mapping 8000:5000)|
                   +---------------------------+
```

Command:
- Build image: `docker build -t testing/welcome .`
- Run container: `docker run -d -p 8000:5000 testing/welcome`

**Docker Compose:** Mengelola container dengan konfigurasi YAML.

---

## **3. CI/CD - GitHub Actions**
Pipeline otomatisasi CI/CD dengan GitHub Actions:
- **Build & Push Docker Image** ke registry publik.
- **Deploy ke VM menggunakan SSH (Opsional).**

```
                        +-----------------------+
                        | GitHub Repository     |
                        +-----------+-----------+
                                    |
                                    v
                        +-----------------------+
                        | GitHub Actions        |
                        | CI/CD Pipeline        |
                        +-----------+-----------+
                                    |
                                    v
              +--------------------------------------+
              |   Docker Registry (Docker Hub)      |
              +--------------------------------------+
                                    |
                                    v
              +--------------------------------------+
              |    VM Deployment via SSH (Bonus)   |
              +--------------------------------------+
```

---

## **4. Kubernetes Deployment**
Setelah Docker Image tersedia, dideploy ke Kubernetes dengan komponen berikut:
- **ConfigMap & Secret** (Konfigurasi & informasi sensitif)
- **Deployment** (Menjalankan aplikasi dengan auto-scaling)
- **Service** (Expose aplikasi di dalam cluster)
- **Ingress** (Mengelola trafik eksternal)

```
                        +-------------------+
                        |       Users       |
                        +--------+----------+
                                 |
                                 v
                   +---------------------------+
                   |    Kubernetes Ingress     |
                   |   (Nginx, HTTPS w/ SSL)   |
                   +-------------+-------------+
                                 |
                                 v
                   +---------------------------+
                   |        Kubernetes         |
                   |     (GKE Cluster)         |
                   +-------------+-------------+
                                 |
        +-----------------+------+-----------------+
        |                 |                        |
        v                 v                        v
 +-------------+   +----------------+   +----------------+
 | Cloud SQL   |   |  Cloud Storage |   |  Cloud DNS      |
 | (Database)  |   |  (Static Files)|   | (Domain & Sub)  |
 +-------------+   +----------------+   +----------------+
```



