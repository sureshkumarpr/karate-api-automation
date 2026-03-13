# Maven Version Guide for Java 19

## 🎯 Recommended Maven Version for Java 19

### **Maven 3.9.6 (Latest Stable)**
**✅ RECOMMENDED FOR JAVA 19**

**Download**: https://maven.apache.org/download.cgi
**Direct Link**: https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
**File Size**: 8.5 MB
**Release Date**: February 2024

---

## 📋 Maven Version Compatibility

| Maven Version | Java 19 Support | Status | Recommendation |
|---------------|----------------|--------|----------------|
| **Maven 3.9.6** | ✅ Full Support | ✅ **BEST** | **Recommended** |
| Maven 3.9.5 | ✅ Full Support | ✅ Good | Alternative |
| Maven 3.9.4 | ✅ Full Support | ✅ Good | Alternative |
| Maven 3.8.8 | ⚠️ Limited | ⚠️ Avoid | Not recommended |
| Maven 3.6.3 | ❌ No Support | ❌ Don't Use | Incompatible |

---

## 🚀 Why Maven 3.9.6 with Java 19?

### **Perfect Compatibility**
- ✅ **Officially supports Java 19**
- ✅ **Latest security patches**
- ✅ **Performance optimizations**
- ✅ **Bug fixes for newer Java versions**

### **Key Benefits**
- **Faster builds** with Java 19
- **Better dependency management**
- **Improved plugin compatibility**
- **Enhanced error reporting**

---

## 📦 Installation Steps

### **Step 1: Download Maven 3.9.6**
```batch
# Download using curl
curl -L "https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip" -o apache-maven-3.9.6-bin.zip
```

### **Step 2: Extract Maven**
1. Extract `apache-maven-3.9.6-bin.zip`
2. Extract to: `C:\Program Files\Apache\Maven\`
3. Final path: `C:\Program Files\Apache\Maven\apache-maven-3.9.6`

### **Step 3: Set Environment Variables**
```batch
# Add to System Environment Variables
MAVEN_HOME=C:\Program Files\Apache\Maven\apache-maven-3.9.6
PATH=%PATH%;%MAVEN_HOME%\bin
```

### **Step 4: Verify Installation**
```batch
# Check Maven version
mvn -version
# Should show: Apache Maven 3.9.6

# Check Java version
java -version
# Should show: java version "19"
```

---

## 🔧 Maven Configuration for Java 19

### **pom.xml Compiler Settings**
```xml
<properties>
    <maven.compiler.source>19</maven.compiler.source>
    <maven.compiler.target>19</maven.compiler.target>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
</properties>

<build>
    <plugins>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <version>3.11.0</version>
            <configuration>
                <source>19</source>
                <target>19</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

### **Maven Options for Java 19**
```batch
# Set Maven options for Java 19
set MAVEN_OPTS=-Xmx2g -Xms1g -XX:+UseG1GC

# Run tests with Java 19
mvn clean test -Dmaven.compiler.source=19 -Dmaven.compiler.target=19
```

---

## 🎯 Quick Commands

### **Verify Setup**
```batch
# Check all versions
java -version
mvn -version
git --version
```

### **Run Karate with Java 19 + Maven 3.9.6**
```batch
# Clone repository
git clone https://github.com/sureshkumarpr/karate-api-automation.git
cd karate-api-automation

# Run tests
mvn clean test

# Run specific tests
mvn test -Dkarate.options="--tags @smoke"
```

---

## 📊 Performance Comparison

| Maven Version | Build Time (Java 19) | Memory Usage | Stability |
|---------------|---------------------|--------------|-----------|
| **Maven 3.9.6** | **Fastest** | **Optimized** | **Best** |
| Maven 3.9.5 | Fast | Good | Good |
| Maven 3.8.8 | Slow | High | Issues |

---

## 🔍 Troubleshooting

### **Common Issues**

**Problem**: Maven can't find Java 19
```batch
# Solution: Set JAVA_HOME
set JAVA_HOME=C:\Program Files\Java\jdk-19
set PATH=%PATH%;%JAVA_HOME%\bin
```

**Problem**: Maven version too old
```batch
# Solution: Upgrade to Maven 3.9.6
mvn -version
# Should show 3.9.6, not 3.8.x or older
```

**Problem**: Compilation errors
```batch
# Solution: Update compiler plugin
mvn clean install -U
```

---

## 🎯 My Recommendation

**For Java 19, install Maven 3.9.6:**

> **"Download Maven 3.9.6 - it's the latest version with full Java 19 support.
> 
> **Download**: https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
> 
> **Installation**:
> 1. Extract to C:\Program Files\Apache\Maven\
> 2. Add MAVEN_HOME environment variable
> 3. Add to PATH
> 4. Verify with `mvn -version`
> 
> This combination gives you the best performance and compatibility!"**

---

## 📦 Download Summary

### **Required: Maven 3.9.6**
- **Size**: 8.5 MB
- **Download**: https://dlcdn.apache.org/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.zip
- **Install Time**: 2 minutes
- **Java 19 Support**: ✅ Full

### **Optional: Git 2.44.0**
- **Size**: 50 MB
- **Download**: https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe
- **Install Time**: 2 minutes

---

**Bottom Line: Install Maven 3.9.6 - it's the perfect match for your Java 19!**
