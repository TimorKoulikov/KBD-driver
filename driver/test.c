#include <linux/fs.h>
#include <linux/init.h>
#include <linux/module.h>

static int major;

/**
 *file operation functions
 */
static ssize_t my_read(struct file *f, char __user *u, size_t l, loff_t *o) {
  printk("dev - Read is called\n");
  return 0;
}

static struct file_operations fops = {.read = my_read};
/**
 * @brief This function is called, when the module is loaded into the kernel
 */
static int __init my_init(void) {

  major = register_chrdev(0, "module_dev", &fops);
  if (major < 0) {
    printk("error register char device file\n");
    return major;
  }
  printk("successfull init: major number is :%d\n", major);
  return 0;
}

/**
 * @brief This function is called, when the module is removed from the kernel
 */
static void __exit my_exit(void) {

  unregister_chrdev(major, "module_dev");
  printk("Goodbye, Kernel\n");
}

module_init(my_init);
module_exit(my_exit);

/* Meta Information */
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Johannes 4 GNU/Linux");
MODULE_DESCRIPTION("A hello world LKM");
