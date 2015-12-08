/*
 * Copyright (C) 2005-2015 Alfresco Software Limited.
 *
 * This file is part of Alfresco
 *
 * Alfresco is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Alfresco is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with Alfresco. If not, see <http://www.gnu.org/licenses/>.
 */

package org.springframework.web.context.support;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

import org.springframework.core.io.AbstractResource;
import org.springframework.core.io.Resource;
import org.springframework.extensions.webscripts.Store;
import org.springframework.util.StringUtils;

/**
 * Spring resource implementation which describes a resource that is
 * located within an Alfresco Store.
 * 
 * The Alfresco Store within which the resource is located could be any
 * of the conventional Alfresco Store types, including:
 * 
 *      ClassPathStore
 *      RemoteStore
 *      LocalFileSystemStore
 *      WebApplicationStore
 *      
 * Store resources empower Spring to load resources from Alfresco Store
 * implementations.  This essentially includes beans and bean imports
 * performed by service locators within Spring.
 * 
 * @author muzquiano
 */
public class StoreResource extends AbstractResource 
{
    private final Store store;
    private final String path;


    /**
     * Constructs a new store resource
     * 
     * @param store The store within which the resource lives
     * @param path Path to the resource
     */
    public StoreResource(Store store, String path) 
    {
        this.store = store;
        
        // check path
        if (!path.startsWith("/")) {
            path = "/" + path;
        }
        this.path = StringUtils.cleanPath(path);
    }

    /**
     * Return the Store for this resource.
     */
    public final Store getStore() {
        return store;
    }

    /**
     * Return the path for this resource.
     */
    public final String getPath() {
        return path;
    }

    /* (non-Javadoc)
     * @see org.springframework.core.io.InputStreamSource#getInputStream()
     */
    public InputStream getInputStream() throws IOException 
    {
        InputStream is = this.store.getDocument(this.path);
        if (is == null) {
            throw new FileNotFoundException("Could not open " + getDescription());
        }
        return is;
    }

    /* (non-Javadoc)
     * @see org.springframework.core.io.AbstractResource#getFilename()
     */
    public String getFilename() {
        return StringUtils.getFilename(this.path);
    }

    /* (non-Javadoc)
     * @see org.springframework.core.io.AbstractResource#getDescription()
     */
    public String getDescription() {
        return "Store resource [" + this.path + "]";
    }

    /* (non-Javadoc)
     * @see org.springframework.core.io.AbstractResource#equals(java.lang.Object)
     */
    public boolean equals(Object obj) 
    {
        if (obj == this) 
        {
            return true;
        }
        if (obj instanceof StoreResource) 
        {
            StoreResource otherRes = (StoreResource) obj;
            return (this.store.equals(otherRes.getStore()) && this.path.equals(otherRes.path));
        }
        
        return false;
    }

    /* (non-Javadoc)
     * @see org.springframework.core.io.AbstractResource#hashCode()
     */
    public int hashCode() {
        return this.path.hashCode();
    }

    /* (non-Javadoc)
     * @see org.springframework.core.io.AbstractResource#createRelative(java.lang.String)
     */
    public Resource createRelative(String relativePath) throws IOException 
    {
        String newPath = getPath();
        
        // strip back the filename so that we have the container path
        int i = newPath.lastIndexOf("/");
        newPath = newPath.substring(0,i);
        
        if (!relativePath.startsWith("/"))
        {
            newPath = newPath + "/";
        }
        newPath = newPath + relativePath;
        
        return new StoreResource(getStore(), newPath);
    }
}
